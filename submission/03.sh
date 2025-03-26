# Created a SegWit address.
# Add funds to the address.
# Return only the Address

WALLET_NAME="btrustwallet"

bitcoin-cli -regtest loadwallet "$WALLET_NAME"


NEW_ADDRESS=$(bitcoin-cli -regtest getnewaddress "Funding Address" "bech32")


bitcoin-cli -regtest generatetoaddress 101 "$NEW_ADDRESS" > /dev/null


echo "$NEW_ADDRESS"
