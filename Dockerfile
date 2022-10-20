FROM ruby:3.0.0


# install rails dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev \
    curl gnupg2 apt-utils libmariadb-dev-compat libmariadb-dev git libcurl3-dev cmake \
    libssl-dev pkg-config openssl imagemagick libmariadb-dev file yarn

RUN apt-get install dialog apt-utils -y

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get -y install nodejs


WORKDIR /admin_eazy_card

COPY Gemfile* ./

RUN gem install bundler:2.3.11
RUN bundle install

COPY . .

#RUN npm install --production

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y yarn
RUN bundle exec yarn install --check-files


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
