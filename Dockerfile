# build phase
FROM node:21-alpine as builder

WORKDIR usr/app
COPY ./package.json ./
RUN npm i
COPY ./ ./ 

RUN npm run build

# run phase
FROM nginx
# copy over the result of the build phase
# we use --from=builder as defined in the FROM of the build phase
COPY --from=builder ./usr/app/build ./usr/share/nginx/html
