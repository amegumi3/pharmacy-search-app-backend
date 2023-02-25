FROM ruby:3.0.4-slim

RUN apt-get -y update
RUN apt-get -y install make build-essential
RUN apt-get -y install nodejs sqlite3 libsqlite3-dev
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

RUN gem install -v 6.1.7 rails
COPY . /app

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
