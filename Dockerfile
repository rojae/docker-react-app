FROM node:alpine as builder

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./

RUN npm run build
RUN npm run test -- --coverage
RUN npm run start

FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html