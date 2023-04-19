FROM amazonlinux:2022
RUN dnf check-update
RUN dnf update
RUN dnf install -y nodejs npm
ENV NODE_ENV production
WORKDIR /usr/src/app
COPY ./build /usr/src/app/build
COPY ./package.json /usr/src/app/package.json
COPY ./package-lock.json /usr/src/app/package-lock.json
RUN npm ci --only=production
EXPOSE 80
CMD ["node", "--experimental-specifier-resolution=node", "build/server.js"]