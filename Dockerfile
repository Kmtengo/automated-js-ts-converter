FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    nodejs \
    git

RUN npm i convert-js-to-ts -g

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]