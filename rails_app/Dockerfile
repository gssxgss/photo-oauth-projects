FROM ruby:3.3.6-slim

ARG APP_DIR=/rails_app

ENV TZ="Asia/Tokyo"
ENV RAILS_LOG_TO_STDOUT="1"
ENV PIDFILE="/tmp/server.pid"
ENV RAILS_SERVE_STATIC_FILES="true"

# ENV RAILS_ENV="production"
# ENV BUNDLE_WITHOUT="development"


RUN set -ex \
    && apt-get update \
    && apt-get install -y curl gnupg vim \
    && curl -sL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y build-essential libvips nodejs postgresql-client file tzdata shared-mime-info  \
    && apt-get clean \
    && gem install bundler

WORKDIR $APP_DIR

COPY ./Gemfile ./Gemfile.lock ${APP_DIR}/
RUN bundle install

# COPY . .

# RUN bundle exec bootsnap precompile --gemfile rails_app/ lib/

# RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["bash", "-c", "rm -f /tmp/server.pid && rails s -b 0.0.0.0"]
