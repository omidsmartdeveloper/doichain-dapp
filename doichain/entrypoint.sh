#!/bin/bash
set -euo pipefail

_RPC_PORT=${RPC_PORT}
_NODE_PORT=${NODE_PORT}
_DAPP_URL=${DAPP_URL}
_REGTEST=0
_TESTNET=0

if [ $REGTEST = true ]; then
	_REGTEST=1
	_RPC_PORT=$RPC_PORT_REGTEST
  	_NODE_PORT=$NODE_PORT_REGTEST
fi

if [ $TESTNET = true ]; then
	_TESTNET=1
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

if [ -z ${DAPP_URL} ]; then
	_DAPP_URL=$DAPP_URL
fi

DOICHAIN_CONF_FILE=/home/doichain/data/doichain/doichain.conf
if [ ! -f "$DOICHAIN_CONF_FILE" ]; then
echo "DOICHAIN_CONF_FILE not found - generating new!"
echo "
regtest=$_REGTEST
testnet=$_TESTNET
daemon=1
server=1
wallet=1
rpcuser=${RPC_USER}
rpcpassword=${RPC_PASSWORD}
rpcbind=0.0.0.0
rpcallowip=${RPC_ALLOW_IP}
txindex=1
fallbackfee=0.0002
namehistory=1
rpcworkqueue=100
blocknotify=curl -X GET ${DAPP_URL}/api/v1/blocknotify?block=%s
walletnotify=curl -X GET ${DAPP_URL}/api/v1/walletnotify?tx=%s

[test]
rpcport=${_RPC_PORT}
rpcbind=0.0.0.0
rpcallowip=0.0.0.0/0
wallet=1
port=${_NODE_PORT}

[regtest]
rpcport=${_RPC_PORT}
rpcbind=0.0.0.0
rpcallowip=0.0.0.0/0
wallet=1
port=${_NODE_PORT}" > $DOICHAIN_CONF_FILE
fi

exec "$@"
