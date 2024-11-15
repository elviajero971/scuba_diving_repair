# Base image: Official Ruby image
FROM ruby:3.2.0-slim-bullseye

# Set the working directory inside the Docker container
WORKDIR /app

# Update and install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends build-essential curl git libvips

# Copy Gemfile and Gemfile.lock to Docker container
COPY Gemfile Gemfile.lock ./

# Install Bundler and the required gems
RUN bundle install

# Copy the entire Rails application into the container
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Run the database migrations
RUN bundle exec rake db:migrate

# Expose the Rails default port 3000
EXPOSE 3000

# Command to run the Rails server
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"]
