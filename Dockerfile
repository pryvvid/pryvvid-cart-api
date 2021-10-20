FROM node:14.18.1-alpine
WORKDIR /usr/app
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build
EXPOSE 4000
CMD ["npm", "run", "start:prod"]