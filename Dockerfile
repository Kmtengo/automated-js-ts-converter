FROM ubuntu:latest

WORKDIR /usr/app

RUN apt-get update && apt-get install -y \
    curl \
    git \
    gh

# Install Node.js 20
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# Install npm 9
RUN npm install -g npm@9

RUN npm cache clean --force

RUN npm install -g ts-migrate

RUN pwd

RUN chmod -R 775 /automated-js-ts-converter/entrypoint.sh

ENTRYPOINT ["/automated-js-ts-converter/entrypoint.sh"]
