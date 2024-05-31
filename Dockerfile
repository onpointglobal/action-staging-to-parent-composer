# Container image that runs your code
FROM composer:2.2.21

RUN apk update \
    && apk add git \
    && apk add jq

# install composer
# RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
# RUN php -r "unlink('composer-setup.php');"


# RUN curl -fsSLO https://github.com/cli/cli/releases/download/v1.7.0/gh_1.7.0_linux_386.tar.gz
# RUN tar -zvxf gh_1.7.0_linux_386.tar.gz
# RUN chmod +x gh_1.7.0_linux_386/bin/gh
# RUN cp gh_1.7.0_linux_386/bin/gh /usr/local/bin/
# RUN rm -rf gh_1.7.0_linux_386.tar.gz && rm -rf gh_1.7.0_linux_386
# RUN gh --version
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh


# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]