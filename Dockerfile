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

# Install the Bundler version specified in Gemfile.lock
RUN gem install bundler -v "$(grep -A 1 'BUNDLED WITH' Gemfile.lock | tail -n 1 | xargs)" && \
    bundle config set --global path '/usr/local/bundle' && \
    bundle install --jobs=4 --retry=3
