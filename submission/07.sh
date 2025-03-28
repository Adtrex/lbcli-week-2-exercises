# Create a raw transaction with an amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
# raw_tx="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"


recipient_address="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"
amount_to_send=0.2

raw_tx="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"


decoded_tx=$(bitcoin-cli -regtest decoderawtransaction "$raw_tx")


utxo_txid=$(echo "$decoded_tx" | jq -r '.txid')


inputs="["
num_utxos=$(echo "$decoded_tx" | jq '.vout | length')
for (( i=0; i<num_utxos; i++ )); do
    vout_index=$(echo "$decoded_tx" | jq -r ".vout[$i].n")
    inputs+="{\"txid\":\"$utxo_txid\",\"vout\":$vout_index},"
done
inputs=${inputs%,}
inputs+="]"

# utxo_vout=$(echo "$decoded_tx" | jq -r '.vout[0].n')

rawtxhex=$(bitcoin-cli -regtest createrawtransaction "$inputs" "{ \"$recipient_address\": $amount_to_send }")


# rawtxhex=$(bitcoin-cli -regtest createrawtransaction '''[ { "txid": "'$utxo_txid'", "vout": '$utxo_vout' } ]''' '''{ "'$recipient_address'": "'$amount_to_send'" }''')

echo "$rawtxhex"
