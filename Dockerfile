# Container image that runs your code
FROM php:7.4-fpm-alpine3.12

RUN apk update \
    && apk add git \
    && apk add jq

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

RUN mkdir /ghcli
WORKDIR /ghcli

RUN curl -fsSLO https://github.com/cli/cli/releases/download/v1.7.0/gh_1.7.0_linux_386.tar.gz
RUN tar -zvxf gh_1.7.0_linux_386.tar.gz -C /usr/local/bin
RUN mv gh_1.7.0_linux_386/bin/gh /usr/local/bin/
RUN export PATH=$PATH:/usr/local/gh
RUN gh --version
# Copies your code file from your action repository to the filesystem path `/` of the container
WORKDIR /
COPY entrypoint.sh /entrypoint.sh


# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]