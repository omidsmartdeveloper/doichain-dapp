# FROM node:12
FROM ubuntu:20.04 AS buck

ARG DOICHAIN_DAPP_VER=master
ENV DOICHAIN_DAPP_VER $DOICHAIN_DAPP_VER

ARG DAPP_HOST="localhost"
ENV DAPP_HOST $DAPP_HOST

ARG DAPP_PORT=3000
ENV DAPP_PORT $DAPP_PORT

# RUN apt update && apt install -y --no-cache bash git curl
RUN apt update -qq && apt install -qq -y --no-install-recommends \
    bash git curl ca-certificates \
    && (curl https://install.meteor.com/  | sh)  
  #  && git clone --branch ${DOICHAIN_DAPP_VER} https://github.com/Doichain/dapp.git && cd dapp      
    # \ && meteor npm install --save bcrypt && meteor build build/ --architecture os.linux.x86_64 --directory --server ${DAPP_HOST}:${DAPP_PORT}

