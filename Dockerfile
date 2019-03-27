FROM ruby:2.3-slim-stretch

RUN apt-get update && apt-get install -y build-essential mysql-client default-libmysqlclient-dev --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 4 --retry 5
RUN gem install foreman
COPY . ./
EXPOSE 3000
ENTRYPOINT ["bundle", "exec"]
CMD ["foreman", "s", "-p", "3000"]
