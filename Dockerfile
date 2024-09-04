FROM node:20

RUN apt-get update && apt-get install -y \
    git \
    gh

RUN npm install -g npm@10

RUN npm cache clean --force

RUN npm i ts-migrate

COPY entrypoint.sh /entrypoint.sh

RUN chmod -R 775 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
