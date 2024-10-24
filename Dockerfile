# Base image: Official Ruby image with a specific version (Debian-based)
FROM ruby:3.2.0-slim-bullseye

# Set the working directory inside the Docker container
WORKDIR /app

# Copy Gemfile and Gemfile.lock to Docker container
COPY Gemfile Gemfile.lock ./

# Install Bundler and the required gems (without development and test groups)
RUN bundle install

# Copy the entire Rails application into the container
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the Rails default port 3000
EXPOSE 3000

# Start the Rails server on port 3000 (inside the container)
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
