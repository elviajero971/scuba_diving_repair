# Base image: Official Ruby image with a specific version (Debian-based)
FROM ruby:3.2.0

# Ensure apt-get is non-interactive, update system packages, and install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  wget \
  locales \
  libssl-dev \
  zlib1g-dev \
  libreadline-dev \
  libyaml-dev \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  software-properties-common \
  apt-transport-https \
  ca-certificates \
  gnupg2 \
  nodejs \
  postgresql-client \
  yarn \
  apache2 \
  libapache2-mod-passenger \
  apache2-dev

## Install or update glibc to version 2.31
#RUN wget http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/libc6_2.31-0ubuntu9_amd64.deb && \
#    dpkg -i libc6_2.31-0ubuntu9_amd64.deb && \
#    rm libc6_2.31-0ubuntu9_amd64.deb

# Set the working directory inside the Docker container
WORKDIR /app

# Copy Gemfile and Gemfile.lock to Docker container
COPY Gemfile Gemfile.lock ./

# Install Bundler and the required gems (without development and test groups)
RUN gem install bundler && \
    bundle config set without 'development test' && \
    bundle install

# Copy the entire Rails application into the container
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the Rails default port 3000
EXPOSE 3000

# Start the Rails server on port 3000 (inside the container)
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
