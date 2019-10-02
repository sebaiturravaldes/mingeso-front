#############
### Build ###
#############

# Base image
FROM node:10.15.3-alpine as build

# Set working directory
WORKDIR /app

RUN rm -rf /tmp/* /var/cache/apk/*

# Install app dependencies
COPY . /app
COPY .env.example ./.env
RUN npm install

# Generate build
RUN npm run build

# Run test build
RUN npm test

############
### Prod ###
############

# Base image
FROM nginx:alpine

# Copy artifact build from the 'build environment'
COPY --from=build /app/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
