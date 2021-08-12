FROM node:16.6.2 AS build

ENV CI=true
WORKDIR /app
COPY .yarn/ .yarn/
COPY package.json .yarnrc.yml yarn.lock ./
RUN yarn install --immutable --check-cache

COPY . .
RUN yarn build

FROM nginx
COPY --from=build /app/build/ /usr/share/nginx/html
