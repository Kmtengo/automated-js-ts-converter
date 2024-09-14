FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    curl \
    git \
    gh

# Install Node.js 20 and npm 10
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g npm@0.1.35

RUN npm cache clean --force

RUN npm install --save-dev ts-migrate

COPY entrypoint.sh /entrypoint.sh

RUN chmod -R 775 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
