#!/bin/bash

sleep 5

# Extract the algod.token
ALGOD_TOKEN=$(cat /algod/data/algod.token)

# Create the .goracle file with the extracted token, mnemonic, and the user's main Algorand public address
cat > "/root/.goracle" << EOL
{
  "blockchain": {
    "server": "http://$ALGORAND_NODE_IP:8080",
    "token": "$ALGOD_TOKEN",
    "mnemonic": "$PARTICIPATION_SEED_PHRASE",
    "mainAddr": "$MAIN_ADDRESS_PUBLIC_KEY"
  }
}
EOL

# Wait for the Algorand node to catch up
while true; do
  RESPONSE=$(curl -s -H "X-Algo-API-Token: $ALGOD_TOKEN" "http://$ALGORAND_NODE_IP:8080/v2/status")

  LAST_ROUND=$(echo "$RESPONSE" | jq '.["last-round"]')
  CATCHUP_TIME=$(echo "$RESPONSE" | jq '.["catchup-time"]')
  catchup_seconds=$((CATCHUP_TIME / 1000000000))
  hours=$((catchup_seconds / 3600))
  minutes=$(( (catchup_seconds % 3600) / 60 ))
  seconds=$((catchup_seconds % 60))
  formatted_catchup_time=$(printf "%02d:%02d:%02d" $hours $minutes $seconds)

  if [ "$CATCHUP_TIME" -eq 0 ]; then
    echo "Node is caught up. Last round: $LAST_ROUND"
    break
  else
    echo "Node is still catching up. Last round: $LAST_ROUND, Catchup time: $formatted_catchup_time"
    sleep 60
  fi
done

# Start Goracle Node Runner
/usr/bin/node --trace-uncaught ./node_runner.js
