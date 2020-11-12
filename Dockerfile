FROM node:12
WORKDIR /usr/src/app
COPY node-app/package*.json ./
RUN npm install
COPY node-app/ .
EXPOSE 8081
CMD ["node", "server.js"]
