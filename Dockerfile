# Base image: Official Ruby image with a specific version
FROM ruby:3.2.0

# Install dependencies including Apache, Passenger, NodeJS, PostgreSQL client, and Yarn
RUN apt-get update -qq && apt-get install -y \
  apache2 \
  libapache2-mod-passenger \
  nodejs \
  postgresql-client \
  yarn \
  build-essential \
  apache2-dev

# Set working directory inside the Docker container
WORKDIR /app

# Copy Gemfile and Gemfile.lock to Docker container
COPY Gemfile Gemfile.lock ./

# Install Bundler and the required gems
RUN gem install bundler && bundle install --without development test

# Copy the Rails app source code to the container
COPY . .

# Ensure the .env file is copied during the build process
COPY .env /app/.env

# Precompile assets
RUN bundle exec rake assets:precompile

# Enable Passenger and Apache modules
RUN a2enmod passenger

# Expose port 80 to make Apache accessible
EXPOSE 80

# Start Apache and Passenger, make sure .env is loaded
CMD source /app/.env && service apache2 restart && tail -f /dev/null
