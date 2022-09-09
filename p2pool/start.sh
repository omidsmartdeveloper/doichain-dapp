set -euo pipefail

echo "connecting the merged mining url ${MERGED_MINGIN_URL} with for \nDoichain payout address${P2POOL_DOICHAIN_DEFAULT_ADDR} and \nBitcoin payout address ${P2POOL_BITCOIN_DEFAULT_ADDR}"

nohup /usr/bin/pypy /usr/src/p2pool/run_p2pool.py --net bitcoin --bitcoind-address bitcoin --merged_addr ${MERGED_MINGIN_URL}/?payout=${P2POOL_DOICHAIN_DEFAULT_ADDR} -a $P2POOL_BITCOIN_DEFAULT_ADDR -n p2pool.org --give-author=0

exec /bin/bash
