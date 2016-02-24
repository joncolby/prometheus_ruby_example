FROM phusion/passenger-ruby22:0.9.18
MAINTAINER Jonathan Colby

# Set correct environment variables.
ENV HOME /root
ENV APP_HOME /home/app/webapp
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

RUN rm /etc/nginx/sites-enabled/default
COPY files/webapp.conf /etc/nginx/sites-enabled/webapp.conf
COPY files/env.conf /etc/nginx/main.d/env.conf
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/public
RUN mkdir $APP_HOME/tmp
COPY lib/* $APP_HOME/

RUN gem install bundler

ADD Gemfile* $APP_HOME/

RUN bundle install --without test development

RUN rm -f /etc/service/nginx/down

#RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
