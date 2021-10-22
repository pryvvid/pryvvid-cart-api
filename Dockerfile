FROM node:14.18.1-alpine AS base
WORKDIR /usr/app

# Dependencies
COPY package*.json ./
RUN npm install

# Build
COPY . .
RUN npm run build

# Application
FROM node:14.18.1-alpine AS application
WORKDIR /usr/app

# Copy dependencies from base image and install only needed for prod
COPY --from=base /usr/app/package*.json ./
RUN npm install --only=production

# Copy build from base image
COPY --from=base /usr/app/dist ./dist

ENV PORT=4000
EXPOSE 4000
CMD ["npm", "run", "start:prod"]