FROM node:10.16.3-alpine as install
RUN apk add --no-cache git

FROM install as git
WORKDIR /usr/src/app
USER root
COPY package.json /usr/src/app
RUN npm install

FROM git as build

COPY .env /usr/src/app/.env
COPY components  /usr/src/app/components
COPY i18n.js  /usr/src/app/i18n.js
COPY lib  /usr/src/app/lib
COPY pages  /usr/src/app/pages
COPY public  /usr/src/app/public
COPY redux  /usr/src/app/redux
COPY static  /usr/src/app/static
COPY utils  /usr/src/app/utils
COPY next.config.js  /usr/src/app/next.config.js

RUN npm run build
EXPOSE 3000
RUN date > build_date
RUN cat build_date
CMD npm run start
