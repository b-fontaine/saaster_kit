# Environemnt to install flutter and build web
FROM debian:latest AS build

# install all needed stuff
RUN apt-get update
RUN apt-get install -y curl git unzip

# define variables
ARG FLUTTER_SDK=/usr/local/flutter
ARG FLUTTER_VERSION=stable
ARG APP=/app

ARG FOLDER=website
ARG BASE_HREF=/

#clone flutter
RUN git clone -b $FLUTTER_VERSION https://github.com/flutter/flutter.git $FLUTTER_SDK

# setup the flutter path as an enviromental variable
ENV PATH="$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin:${PATH}"

# Start to run Flutter commands
# doctor to see if all was installes ok
RUN flutter doctor -v

# create folder to copy source code
RUN mkdir $APP
# copy source code to folder
COPY . $APP
# stup new folder as the working directory
WORKDIR $APP/$FOLDER

# Run build: 1 - clean, 2 - pub get, 3 - build web
RUN flutter clean
RUN flutter pub get
RUN flutter build web -t lib/main.dart --release --base-href $BASE_HREF

RUN mkdir -p /app/build/web$BASE_HREF


RUN mv $APP/$FOLDER/build/web/* /app/build/web$BASE_HREF

# once heare the app will be compiled and ready to deploy

# release image: copy just all we need to make the project works from base or from the builder
# use nginx to deploy
FROM nginx:stable-alpine-slim AS release

# copy the info of the builded web app to nginx
COPY --from=build /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

# Expose and run nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
