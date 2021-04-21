#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for bitcoind"

  set -- bitcoind "$@"
fi


if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "bitcoind" ]; then
  mkdir -p "$BITCOIN_DATA"
  chmod 700 "$BITCOIN_DATA"
  chown -R bitcoin "$BITCOIN_DATA"

  echo "$0: setting data directory to $BITCOIN_DATA"

  echo "ls -al $BITCOIN_DATA:"
  ls -al "$BITCOIN_DATA"
  echo "stat $BITCOIN_DATA:"
  stat "$BITCOIN_DATA"
  echo "du $BITCOIN_DATA"
  du "$BITCOIN_DATA"
  echo "cat $BITCOIN_DATA/bitcoin.conf:"
  cat "$BITCOIN_DATA/bitcoin.conf"

  set -- "$@" -datadir="$BITCOIN_DATA"
fi

if [ "$1" = "bitcoind" ] || [ "$1" = "bitcoin-cli" ] || [ "$1" = "bitcoin-tx" ]; then
  echo
  exec gosu bitcoin "$@"
fi

echo
exec "$@"
