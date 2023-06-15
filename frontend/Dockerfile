FROM --platform=linux/amd64 node AS build 

WORKDIR /usr/src/app/

COPY package.json package-lock.json /usr/src/app/

RUN npm install 

COPY . /usr/src/app/

RUN npm run build

FROM --platform=linux/amd64 nginx 

RUN rm -rf /etc/nginx/conf.d/default.conf 

COPY frontend.conf /etc/nginx/conf.d/frontend.conf

EXPOSE 80

COPY --from=build /usr/src/app/build/ /usr/share/nginx/html/