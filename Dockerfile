ARG RUBY_VERSION=3.2.0

# ===========================
# Stage 1: Base Setup
# ===========================
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Set working directory
WORKDIR /app

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"

# ===========================
# Stage 2: Build Assets
# ===========================
FROM base AS build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    node-gyp \
    python-is-python3 \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    libvips \
    curl \
    libcairo2-dev \
    libgirepository1.0-dev \
    libpoppler-glib-dev \
    poppler-utils \
    libxml2-dev \
    libxslt1-dev \
    imagemagick \
    pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install JavaScript dependencies
ARG NODE_VERSION=22.11.0
ARG YARN_VERSION=1.22.22
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /tmp/node-build-master

# Install application gems
COPY Gemfile Gemfile.lock ./

# Extract and install the exact Bundler version from Gemfile.lock
RUN BUNDLER_VERSION=$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1 | tr -d ' ') && \
    gem install bundler -v "$BUNDLER_VERSION" && \
    bundle install && \
    rm -rf ~/.bundle/ "/usr/local/bundle"/ruby/*/cache "/usr/local/bundle"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile


# Install node modules
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompile assets for production without requiring secret RAILS_MASTER_KEY
ENV NODE_OPTIONS=--openssl-legacy-provider
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# # Final stage for app image
FROM base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    node-gyp \
    python-is-python3 \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    libvips \
    curl \
    libcairo2-dev \
    libgirepository1.0-dev \
    libpoppler-glib-dev \
    poppler-utils \
    imagemagick \
    pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install Certbot
RUN apt-get update -qq && apt-get install -y --no-install-recommends certbot && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install JavaScript dependencies
ARG NODE_VERSION=22.11.0
ARG YARN_VERSION=1.22.22
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /tmp/node-build-master

# # Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Remove the custom entrypoint
# ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
