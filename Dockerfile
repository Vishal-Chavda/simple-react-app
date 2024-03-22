#First Stage
FROM node:18 as ui-builder
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH
COPY package.json /usr/src/app/package.json
RUN npm i
COPY . /usr/src/app
RUN npm run build

#Second Stage
FROM nginx
COPY  --from=ui-builder /usr/src/app/build /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
