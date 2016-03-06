FROM ruby:2.2.4
ADD . /code
WORKDIR /code
RUN apt-get update -y
RUN apt-get install -y nodejs --no-install-recommends
RUN rm -rf /var/lib/apt/lists/*
RUN gem install bundler
RUN bundle config --global jobs 8
RUN bundle install --without test
RUN rake db:migrate
RUN rake db:reset
RUN rake db:populate
CMD ["rails", "server", "-b", "0.0.0.0"]
