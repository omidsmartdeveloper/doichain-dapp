# Doichain Docker Compose Environment

## Description
This repository provides the necessary Docker Compose file, Dockerfiles and/or images to start a complete Doichain Node environment including:
- Doichain Core Node
- P2Pool (P2P Merge Mining Pool to merge mine Bitcoin and Doichain)
- Bitcoin Core Node (pruned) dependency to merge mine Doichain via P2Pool
- (planned) ElectrumX Server
- Doichain dApp (for Email Marketing)
- MongoDB (dependency for Doichain dApp)
- (planned) Mail Server (dependency for Doichain dApp)

## Installation process
1. Clone this repo 
2. Run ```docker-compose up -d``` in order to start the Doichain Node environment
3. Run ```docker-compose down``` in order to start the Doichain Node environment

## Configuration
The configuration can be enterirly done inside the docker compose file


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

## Basics to navigate with Doichain P2Pool and Doichain Bitcoind
1. When starting Bitcoind first time, it downloads a pruned Bitcoin blockchain and starts syncing the last "couple of days / weeks" of blocks - please be patients and have a look on the following logs.
2. Check p2pool log ``` docker compose exec p2pool tail -f /home/p2pool/nohup.out```
    - is p2pool connected to bitcoin? Or still showing "Bitcoin Core is in initial sync and waiting for blocks..."
3. Check bitcoind log ```docker compose exec bitcoin tail -f /home/bitcoin/.bitcoin/debug.log``` 

## Basics to navigate with Doichain dApp 
1. Connect to Doichain Container via ```docker-compose exec dapp bash```



