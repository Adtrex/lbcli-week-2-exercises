# Created a SegWit address.
# Add funds to the address.
# Return only the Address


bitcoind -regtest -daemon
sleep 3 


WALLET_NAME="btrustwallet"
EXISTING_WALLETS=$(bitcoin-cli -regtest listwallets | grep -o "$WALLET_NAME")
if [ -z "$EXISTING_WALLETS" ]; then
    bitcoin-cli -regtest createwallet "$WALLET_NAME"
fi

bitcoin-cli -regtest loadwallet "$WALLET_NAME"


NEW_ADDRESS=$(bitcoin-cli -regtest getnewaddress "Funding Address" "bech32")


bitcoin-cli -regtest generatetoaddress 101 "$NEW_ADDRESS" > /dev/null


echo "$NEW_ADDRESS"
