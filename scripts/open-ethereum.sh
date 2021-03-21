#!/bin/bash

# Installing and runnning pool

git config --global http.https://gopkg.in.followRedirects true
git clone https://github.com/sammy007/open-ethereum-pool.git


echo -e "\033[32mMake can time as it will download the packages\n"

cd open-ethereum-pool && make
# This is the config file

echo -e "{
	\"threads\": 2,
	\"coin\": \"eth\",
	\"name\": \"main\",

	\"proxy\": {
		\"enabled\": true,
		\"listen\": \"0.0.0.0:8888\",
		\"limitHeadersSize\": 1024,
		\"limitBodySize\": 256,
		\"behindReverseProxy\": false,
		\"blockRefreshInterval\": \"120ms\",
		\"stateUpdateInterval\": \"3s\",
		\"difficulty\": 2000000000,
		\"hashrateExpiration\": \"3h\",

		\"healthCheck\": true,
		\"maxFails\": 100,

		\"stratum\": {
			\"enabled\": true,
			\"listen\": \"0.0.0.0:8008\",
			\"timeout\": \"120s\",
			\"maxConn\": 8192
		},

		\"policy\": {
			\"workers\": 8,
			\"resetInterval\": \"60m\",
			\"refreshInterval\": \"1m\",

			\"banning\": {
				\"enabled\": false,
				\"ipset\": \"blacklist\",
				\"timeout\": 1800,
				\"invalidPercent\": 30,
				\"checkThreshold\": 30,
				\"malformedLimit\": 5
			},
			\"limits\": {
				\"enabled\": false,
				\"limit\": 30,
				\"grace\": \"5m\",
				\"limitJump\": 10
			}
		}
	},

	\"api\": {
		\"enabled\": true,
		\"purgeOnly\": false,
		\"purgeInterval\": \"10m\",
		\"listen\": \"0.0.0.0:8080\",
		\"statsCollectInterval\": \"5s\",
		\"hashrateWindow\": \"30m\",
		\"hashrateLargeWindow\": \"3h\",
		\"luckWindow\": [64, 128, 256],
		\"payments\": 30,
		\"blocks\": 50
	},

	\"upstreamCheckInterval\": \"5s\",
	\"upstream\": [
		{
			\"name\": \"main\",
			\"url\": \"http://127.0.0.1:8545\",
			\"timeout\": \"8s\"
		},
		{
			\"name\": \"backup\",
			\"url\": \"http://127.0.0.2:8545\",
			\"timeout\": \"8s\"
		}
	],

	\"redis\": {
		\"endpoint\": \"127.0.0.1:6379\",
		\"poolSize\": 10,
		\"database\": 0,
		\"password\": \"\"
	},

	\"unlocker\": {
		\"enabled\": false,
		\"poolFee\": 1.0,
		\"poolFeeAddress\": \"\",
		\"donate\": true,
		\"depth\": 120,
		\"immatureDepth\": 20,
		\"keepTxFees\": false,
		\"interval\": \"10m\",
		\"daemon\": \"http://127.0.0.1:8545\",
		\"timeout\": \"10s\"
	},

	\"payouts\": {
		\"enabled\": false,
		\"requirePeers\": 25,
		\"interval\": \"120m\",
		\"daemon\": \"http://127.0.0.1:8545\",
		\"timeout\": \"10s\",
		\"address\": \"0x0\",
		\"gas\": \"21000\",
		\"gasPrice\": \"50000000000\",
		\"autoGas\": true,
		\"threshold\": 500000000,
		\"bgsave\": false
	},

	\"newrelicEnabled\": false,
	\"newrelicName\": \"MyEtherProxy\",
	\"newrelicKey\": \"SECRET_KEY\",
	\"newrelicVerbose\": false
}" > config.json

./build/bin/open-ethereum-pool config.json
