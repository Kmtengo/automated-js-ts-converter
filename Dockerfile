FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    gh \
    git

RUN npm install --save-dev ts-migrate

COPY entrypoint.sh /entrypoint.sh

RUN chmod -R 775 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]