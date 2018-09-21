# Base image
FROM node:latest

# Set application dir
WORKDIR /var/app

# Add sources
ADD ./src .

# Get node-prune (https://github.com/tj/node-prune)
RUN apt-get update && \
    apt-get install --no-install-recommends -y curl && \
    curl -sfL https://install.goreleaser.com/github.com/tj/node-prune.sh | bash

# Install dependencies
RUN npm i

# Set default port
ENV PORT=3000

# Minimize size and start app
ENTRYPOINT ./bin/node-prune && PORT=${PORT} npm start
