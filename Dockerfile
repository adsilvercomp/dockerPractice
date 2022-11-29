# build phase
# use node as a base image and call this part of the build process builder
FROM node:16-alpine as builder
# app is the name of your working directory in the docker container
WORKDIR "/app"
# copy the paackage json over from your working directory to the app directory
COPY ./package.json .
# install your dependecies in the container
RUN npm install
# copy over the other files from your working directory to your docker container
COPY . .
# build your static assets in your docker container
RUN npm run build

# use nginx as a base image
FROM nginx
# copy your build folder over from builder into the folder that nginx serves content from (/usr/share/nginx/html)
COPY --from=builder /app/build /usr/share/nginx/html
# when we use nginx as a base image, the container will automatically start up nginx for us, so we don't have add a command to start up nginx