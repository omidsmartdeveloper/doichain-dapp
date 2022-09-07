#!/usr/bin/env bash
_REGTEST=''
if [ $REGTEST = true ]; then
	_REGTEST='-regtest -addnode='$CONNECTION_NODE
fi

_TESTNET=''
if [ $TESTNET = true ]; then
	_TESTNET='-testnet -addnode='$CONNECTION_NODE
fi

CHAIN_DATA=/home/bitcoin/.bitcoin/database
echo "checking if pruned bitcoin blockchain exists $CHAIN_DATA"
if [ ! -f "$CHAIN_DATA" ]; then
    cd /home/bitcoin/.bitcoin/
    echo "downloading purned bitcoin blockchain from prunednode.today"
    wget https://prunednode.today/latest.zip
    unzip latest.zip
    rm latest.zip
fi

bitcoind $_REGTEST $_TESTNET