# ===========================
# Stage 1: Base Setup
# ===========================
FROM ruby:3.2.0-slim-bullseye AS base

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  git \
  sqlite3 \
  libvips \
  tzdata && \
  rm -rf /var/lib/apt/lists/*

# Add Bundler's bin directory to PATH
ENV PATH="/usr/local/bundle/bin:$PATH"

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle config set --global path '/usr/local/bundle' && \
    bundle install --jobs=4 --retry=3

# ===========================
# Stage 2: Build Assets
# ===========================
FROM base AS build

# Install Node.js and Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

# Set environment for asset precompilation
ENV RAILS_ENV=production
ENV NODE_ENV=production

# Copy the entire application
COPY . .

# Precompile assets
RUN RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 rails assets:precompile

# ===========================
# Stage 3: Production Image
# ===========================
FROM ruby:3.2.0-slim-bullseye AS production

# Set working directory
WORKDIR /app

# Install runtime dependencies only
RUN apt-get update && apt-get install -y --no-install-recommends \
  libvips \
  sqlite3 \
  tzdata && \
  rm -rf /var/lib/apt/lists/*

# Copy gems and runtime files from the base stage
COPY --from=base /usr/local/bundle /usr/local/bundle

# Copy the application and precompiled assets from the build stage
COPY --from=build /app /app

# Use an argument for the master key
ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true

# Expose Rails default port
EXPOSE 3000

# Command to run the Rails server
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"]
