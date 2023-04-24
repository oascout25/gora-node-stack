# Goracle Node Stack
Containerized Goracle node and Algorand Node for easy deployment.

# Goracle Node Stack Deployment Guide
This guide will walk you through the process of deploying your own Goracle Node using Docker Compose. Make sure you have Docker and Docker Compose installed on your system before proceeding.

## Prerequisites
Docker: You will need to have Docker installed on your system. You can download Docker from the official website: https://www.docker.com/get-started

Docker Compose: Install Docker Compose following the instructions here: https://docs.docker.com/compose/install/

Generate a new seed phrase for the participation node. You can use the Algorand Wallet, Algorand CLI tools, or a third-party tool like MyAlgo Wallet (https://wallet.myalgo.com/) to generate a new Algorand wallet. Store the seed phrase and public key safely, as you'll need them in the next steps.

Important: DO NOT use this wallet for any other purpose, as the seed phrase is not secure when used in a Docker container.

## Deploying the Goracle Node
Clone or download the Goracle Node repository: https://github.com/oascout25/goracle-node

Navigate to the directory containing the docker-compose.yml file.

Open the docker-compose.yml file with your preferred text editor.

Update the environment variables under the goracle-node service:

Replace new_seed_phrase_for_participation_node with the seed phrase generated for the participation node in the PARTICIPATION_SEED_PHRASE variable.

Replace your_public_algorand_address with your main wallet's public address in the MAIN_ADDRESS_PUBLIC_KEY variable.

Note: DO NOT use the seed phrase of your main wallet. This will compromise its security.

Save the changes and close the file.

In the terminal, navigate to the directory containing the docker-compose.yml file and run:
```docker-compose up -d```

This command will download the necessary images and create the required volumes, networks, and containers.

Register the public key of the participation node to your Goracle Node by visiting https://testnet-app.goracle.io/nodes and following the instructions.

To monitor the logs of your Goracle Node, run:
```docker-compose logs -f goracle-node```

To monitor the logs of your Algorand Testnet Node, run:
```docker-compose logs -f algorand-testnet-node```

## Stopping the Goracle Node
To stop the Goracle Node and Algorand Testnet Node, run:
```docker-compose down```

This command will stop and remove the containers but will preserve the volumes and networks for future use.
