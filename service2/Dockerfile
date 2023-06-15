FROM node 

WORKDIR /usr/src/app 

COPY package-lock.json package.json /usr/src/app/

RUN npm install 

COPY . . 

CMD ["node", "index.js"]