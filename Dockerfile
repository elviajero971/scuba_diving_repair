ARG RUBY_VERSION=3.2.0

# ===========================
# Stage 1: Base Setup
# ===========================
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim AS base

# Set working directory
WORKDIR /app

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"

# Copy Gemfile early to leverage Docker cache
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN BUNDLER_VERSION=$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1 | tr -d ' ') && \
    gem install bundler -v "$BUNDLER_VERSION" && \
    bundle install && \
    rm -rf ~/.bundle/ "/usr/local/bundle"/ruby/*/cache

# ===========================
# Stage 2: Build Assets
# ===========================
FROM base AS build

# Install system dependencies for assets
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    node-gyp \
    python-is-python3 \
    libvips \
    yarn && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy JavaScript dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy application code
COPY . .

# Precompile assets
RUN bundle exec rails assets:precompile

# ===========================
# Final Stage: Production Image
# ===========================
FROM base

# Copy precompiled assets
COPY --from=build /app /app

# Set up non-root user
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /app
USER rails:rails

EXPOSE 3000
CMD ["./bin/rails", "server"]
