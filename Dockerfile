FROM ruby:alpine as builder
RUN apk add build-base
COPY Gemfile Gemfile.lock .
RUN bundle install

FROM ruby:alpine
WORKDIR /app
ENV LANG ja_JP.UTF-8
RUN gem install bundler
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . /app/
ENTRYPOINT ["bundle", "exec"]
CMD ["bin/run"]
