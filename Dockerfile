FROM ubuntu:16.04
MAINTAINER Gavin Hanson <gavin@cylo.io>

# Install Curl & Supervisor
RUN apt-get update && \
    apt-get install -y --force-yes pwgen \
                                   supervisor \
                                   net-tools \
                                   curl

# Install NodeJS & NPM
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -; \
    apt-get install -y nodejs

ADD configs/supervisord.conf /etc/supervisord.conf
ADD scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /*.sh

EXPOSE 80

CMD [ "/entrypoint.sh" ]