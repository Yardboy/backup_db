FROM ruby:2.6.5

LABEL app-name="s3backups"

RUN apt-get update -qq && apt-get install -y \
  curl \
  vim \
  mariadb-client

# Create and set the working directory
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# COPY app to container
COPY . $APP_HOME
