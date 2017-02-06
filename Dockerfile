FROM ruby:2.3

RUN mkdir -p /var/www/emprego-ja
WORKDIR /var/www/emprego-ja
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

RUN apt-get update
RUN apt-get install nodejs -y
COPY . /var/www/emprego-ja

CMD 'rails server -b 0.0.0.0'
