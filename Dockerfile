# build phase
FROM node:21-alpine as builder

WORKDIR usr/app
COPY ./package.json ./
RUN npm --version
RUN NODE_OPTIONS="--max-old-space-size=4096" npm i
# RUN npm ci
COPY ./ ./ 

RUN npm run build


# run phase
FROM nginx
# copy over the result of the build phase
# we use --from=builder as defined in the FROM of the build phase
EXPOSE 80
COPY --from=builder ./usr/app/build ./usr/share/nginx/html
