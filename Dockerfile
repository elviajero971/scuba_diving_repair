# Base image: Official Ruby image with a specific version
FROM ruby:3.2

# Install essential dependencies for building the Rails app
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn build-essential

# Set working directory inside the Docker container
WORKDIR /app

# Copy Gemfile and Gemfile.lock to Docker container
COPY Gemfile Gemfile.lock ./

# Install Bundler and the required gems
RUN gem install bundler && bundle install --without development test

# Copy the Rails app source code to the container
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3000 to make the Rails app accessible
EXPOSE 3000

# Command to start the Rails app
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
