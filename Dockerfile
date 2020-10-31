FROM ruby:2.7.2-alpine

RUN \
  apk add --no-cache \
    build-base \
    tzdata \
    libcurl \
    ncurses \
    less \
    curl \
    git \
    sqlite-dev

ENV RAILS_LOG_TO_STDOUT true

WORKDIR /app
COPY . /app

RUN bundle install

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
