FROM node:16-alpine as builder
RUN npm install -g npm@8.7.0
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html

