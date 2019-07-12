FROM ruby:alpine as builder
RUN apk add build-base
COPY Gemfile Gemfile.lock .
RUN bundle install

FROM ruby:alpine
LABEL maintainer "cross-ts <ts.kouhei@gmail.com>"
WORKDIR /bot
RUN gem install -N bundler
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . /bot/
ENTRYPOINT ["bundle", "exec"]
CMD ["bin/run"]
