# Create a new Bitcoin address, for receiving change.
bitcoin-cli -regtest loadwallet "btrustwallet"

bitcoin-cli -regtest getnewaddress "Address" "bech32"