FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    nodejs \
    git \
    gh

RUN npm install -g npm@10

RUN npm cache clean --force

RUN npm install --save-dev ts-migrate

COPY entrypoint.sh /entrypoint.sh

RUN chmod -R 775 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
