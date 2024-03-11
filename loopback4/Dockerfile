FROM node:20.11.1

RUN mkdir -p /app
WORKDIR /app
COPY ./src/ .

EXPOSE 3000

ENTRYPOINT [ "node", "server.js" ]
