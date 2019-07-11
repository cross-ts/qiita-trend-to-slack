FROM ruby:alpine
WORKDIR /app
RUN apk add --no-cache build-base
COPY Gemfile Gemfile.lock /app/
RUN bundle install --deployment
COPY src /app/src
COPY bin /app/bin
ENTRYPOINT ["bundle", "exec"]
CMD bin/run
