#!/bin/bash

DAPP_SETTINGS_FILE=/home/doichain/data/dapp/settings.json
if [ ! -f "$DAPP_SETTINGS_FILE" ]; then

	if [ $DAPP_SEND = false ] && [ $DAPP_CONFIRM = false ] && [ $DAPP_VERIFY = false ]; then
		echo "No dApp type is enabled. Please use at least one dApp type or use node-only container instead! (ENV DAPP_SEND, DAPP_CONFIRM, DAPP_VERIFY)"
		exit 1
	fi
	if [ -z "$DAPP_HOST" ]; then
		echo "No host settings found! (ENV DAPP_HOST)"
		exit 1
	fi
	DAPP_SETTINGS='{
	  "app": {
			"debug": "'$DAPP_DEBUG'",
			"host": "'$DAPP_HOST'",
			"port": "'$DAPP_PORT'",
			"ssl": '$DAPP_SSL',
	    "types": ['
	if [ $DAPP_SEND = true ]; then
	  DAPP_SETTINGS=$DAPP_SETTINGS'"send"'
	  if [ $DAPP_CONFIRM = true ] || [ $DAPP_VERIFY = true ]; then
			DAPP_SETTINGS=$DAPP_SETTINGS','
	  fi
	fi
	if [ $DAPP_CONFIRM = true ]; then
	  DAPP_SETTINGS=$DAPP_SETTINGS'"confirm"'
	  if [ $DAPP_VERIFY = true ]; then
			DAPP_SETTINGS=$DAPP_SETTINGS','
	  fi
	fi
	if [ $DAPP_VERIFY = true ]; then
	  DAPP_SETTINGS=$DAPP_SETTINGS'"verify"'
	fi
	DAPP_SETTINGS=$DAPP_SETTINGS']
	  },'


	if [ $DAPP_SEND = true ]; then
	  DAPP_SETTINGS=$DAPP_SETTINGS'"send": {
			"doiMailFetchUrl": "'$DAPP_DOI_URL'",
			"doichain": {
		    "host":"'$RPC_HOST'",
		    "port": "'$RPC_PORT'",
		    "username": "'$RPC_USER'",
		    "password": "'$RPC_PASSWORD'"
		  }
	  }'
	  if [ $DAPP_CONFIRM = true ] || [ $DAPP_VERIFY = true ]; then
			DAPP_SETTINGS=$DAPP_SETTINGS','
	  fi
	fi
	if [ $DAPP_CONFIRM = true ]; then
		if [ -z "$DAPP_SMTP_USER" ] || [ -z "$DAPP_SMTP_HOST" ] || [ -z "$DAPP_SMTP_PORT" ]; then
			echo "Confirmation dApp active but smtp settings not found! (ENV DAPP_SMTP_USER, DAPP_SMTP_PASS, DAPP_SMTP_HOST, DAPP_SMTP_PORT)"
			exit 1
		fi
	  DAPP_SETTINGS=$DAPP_SETTINGS'"confirm": {
			"doichain": {
		      "host":"'$RPC_HOST'",
			  "port": "'$RPC_PORT'",
			  "username": "'$RPC_USER'",
			  "password": "'$RPC_PASSWORD'",
			  "address": "'$CONFIRM_ADDRESS'"
			},
			"smtp": {
		      "username": "'$DAPP_SMTP_USER'",
		      "password": "'$DAPP_SMTP_PASS'",
		      "server":   "'$DAPP_SMTP_HOST'",
		      "smtps":false,
		      "port": "'$DAPP_SMTP_PORT'",
		      "NODE_TLS_REJECT_UNAUTHORIZED":"0",
		      "defaultFrom": "doichain@example-domain.org"
	    }
	  }'
	  if [ $DAPP_VERIFY = true ]; then
			DAPP_SETTINGS=$DAPP_SETTINGS','
	  fi
	fi
	if [ $DAPP_VERIFY = true ]; then
	  DAPP_SETTINGS=$DAPP_SETTINGS'"verify": {
			"doichain": {
		    "host":"'$RPC_HOST'",
		    "port": "'$RPC_PORT'",
		    "username": "'$RPC_USER'",
		    "password": "'$RPC_PASSWORD'"
		  }
	  }'
	fi
	DAPP_SETTINGS=$DAPP_SETTINGS'}'
	echo $DAPP_SETTINGS > $DAPP_SETTINGS_FILE
fi

exec "$@"