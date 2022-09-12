# Doichain Docker Compose Environment

## Description
This repository provides the necessary Docker Compose file, Dockerfiles and/or images to start a complete Doichain Ecosystem such as:
- Doichain Core Node
- Doichain dApp (for Email Marketing)
- MongoDB (dependency for Doichain dApp)
- (planned) P2Pool (P2P Merge Mining Pool to merge mine Bitcoin and Doichain)
- (planned) ElectrumX Server
- (planned) Mail Server

## Installation process
1. Clone this repo ```git clone ````
2. Run ```docker-compose up -d`` in order to start the Doichain Ecosystem
3. Run ```docker-compose down``` in order to start the Doichain Ecosystem

## Configuration
The configuration can be enterirly done inside the docker


## Basics to navigate with Doichain and Docker compose
- show running containers: ```docker-compose ps```
- show all logs of running containers ```docker-compose logs``` 
- connect to a container ```docker-compose exec <containerId> bash``` (or command)


## Basics to navigate on Doichain Node
1. Connect to Doichain Container via ```docker-compose exec doichain bash````
2. Inside of the container you can use the doichain-cli commands such as:
    - doichain-cli help
    - doichain-cli getblockchaininfo
    - doichain-cli getpeerinfo
    - doichain-cli createwallet
    - doichain-cli getbalance
    - doichain-cli getnewaddress
    - doichain-cli getbalance
    - doichain-cli listtransactions
    - doichain-cli gettransaction
    - doichain-cli getrawtransaction
    - doichain-cli getrawmempool

## Basics to navigate with Doichain P2Pool
1. Check p2pool log ``` docker compose exec p2pool tail -f /home/p2pool/nohup.out```
    - is p2pool connected to bitcoin? Or still showing "Bitcoin Core is in initial sync and waiting for blocks..."
2. docker compose exec bitcoin tail -f /home/bitcoin/.bitcoin/debug.log 

## Basics to navigate with Doichain dApp 
1. Connect to Doichain Container via ```docker-compose exec dapp bash```
