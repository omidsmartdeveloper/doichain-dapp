#!/bin/bash
set -euo pipefail

_RPC_PORT=${RPC_PORT}
_NODE_PORT=${NODE_PORT}

if [ $REGTEST = true ]; then
	_RPC_PORT=$RPC_PORT_REGTEST
  _NODE_PORT=$NODE_PORT_REGTEST
fi

if [ $TESTNET = true ]; then
	_RPC_PORT=$RPC_PORT_TESTNET
  	_NODE_PORT=$NODE_PORT_TESTNET
fi

if [ -z ${RPC_USER} ]; then
	RPC_USER='admin'
	echo "RPC_USER was not set, using "$RPC_USER
fi

if [ -z ${RPC_PASSWORD} ]; then
	#echo "generating password"
	RPC_PASSWORD=$(xxd -l 30 -p /dev/urandom)
	echo "RPC_PASSWORD was not set, generated: "$RPC_PASSWORD
fi
echo "loooks good!"
BITCOIN_CONF_FILE=/home/bitcoin/data/bitcoin/bitcoin.conf
if [ ! -f "$BITCOIN_CONF_FILE" ]; then
    echo "BITCOIN_CONF_FILE not found - generating new!"
	echo "
	daemon=1
	server=1
	rpcuser=${RPC_USER}
	rpcpassword=${RPC_PASSWORD}
	rpcallowip=${RPC_ALLOW_IP}
	rpcbind=0.0.0.0
	rpcport=${_RPC_PORT}
	prune=1000
	port=${_NODE_PORT}" > $BITCOIN_CONF_FILE
fi

CHAIN_DATA=/home/bitcoin/data/bitcoin/chainstate/CURRENT
echo "checking if pruned bitcoin blockchain exists $CHAIN_DATA"
if [ ! -f "$CHAIN_DATA" ]; then
    cd /home/bitcoin/data/bitcoin
    echo "downloading purned bitcoin blockchain from prunednode.today"
	curl -L https://www.doi.works/pruned/bitcoin-pruned.tgz  --output bitcoin-pruned.tgz
	tar --exclude='bitcoin.conf' --exclude='bitcoind.pid' --exclude='debug.log' -xzvf  bitcoin-pruned.tgz
	rm bitcoin-pruned.tgz
	#curl -L https://prunednode.today/latest.zip --output latest.zip
    #unzip latest.zip -x bitcoin.conf 
    #rm latest.zip
    chown -R bitcoin:bitcoin *
    cd /home/bitcoin
fi

exec "$@"