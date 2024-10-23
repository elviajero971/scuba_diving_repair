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
  # Additional packages that your app might need (Node.js, Yarn, etc.)
  nodejs \
  postgresql-client \
  yarn \
  apache2 \
  libapache2-mod-passenger \
  apache2-dev

# Install or update glibc to a specific version
RUN wget http://ftp.us.debian.org/debian/pool/main/g/glibc/libc6_2.29-1_amd64.deb && \
    dpkg -i libc6_2.29-1_amd64.deb && \
    rm libc6_2.29-1_amd64.deb

# Install Bundler and your gems
WORKDIR /app

# Copy Gemfile and Gemfile.lock before running bundle install
COPY Gemfile Gemfile.lock ./

# Install Bundler and the required gems (without development and test groups)
RUN gem install bundler && \
    bundle config set without 'development test' && \
    bundle install

# Copy the entire application into the container
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Enable Passenger and Apache modules
RUN a2enmod passenger

# Expose port 80 for the web server
EXPOSE 80

# Start Apache and keep it running
CMD service apache2 restart && tail -f /dev/null
