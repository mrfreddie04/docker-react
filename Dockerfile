# STEP 1 - BUILDER
# base image
FROM node:16-alpine AS builder

# switch user from root to node
USER node

# make directory to host react app & set up workdir
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# copy package.json & install dependencies
COPY --chown=node:node ./package.json ./
RUN npm install

# copy source files
COPY --chown=node:node ./ ./

# set up startup opmmand
RUN npm run build

# STEP 2 - RUNNER
FROM nginx AS runner

COPY --from=builder /home/node/app/build /usr/share/nginx/html