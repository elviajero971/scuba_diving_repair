# Base image: Official Ruby image with a specific version (Debian-based)
FROM ruby:3.2.0-slim-bullseye

# Set the working directory inside the Docker container
WORKDIR /app

#
RUN bash -c "set -o pipefail  && apt-get update "

RUN bash -c "set -o pipefail && apt-get install -y --no-install-recommends build-essential curl git libpq-dev  "

RUN bash -c "set -o pipefail && apt-get install -y --no-install-recommends libvips"

# Copy Gemfile and Gemfile.lock to Docker container
COPY Gemfile Gemfile.lock ./

# Check if files were copied correctly
RUN ls -la

# Install Bundler and the required gems (without development and test groups)
RUN bundle install

# Copy the entire Rails application into the container
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the Rails default port 3000
EXPOSE 3000
