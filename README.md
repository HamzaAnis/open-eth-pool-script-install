![open-eth-pool-script-install](https://socialify.git.ci/HamzaAnis/open-eth-pool-script-install/image?font=Inter&forks=1&issues=1&language=1&pulls=1&stargazers=1&theme=Light)

# Open Ethereum Pool Script for  configuration/setup and installation

This repository will help you to install [open-ethereum-pool][repo]

# Features
  - Setting up the dependencies
  - Will help in configuration for the pool
  - Running the [app][www]

# Recommended OS
  Ubuntu 16.04 or later

### Steps

Open a terminal and login with super user
```sh
$ sudo su
```

Install the dependencies. It will take time --64 flag is for the system architecture
```sh
$ sudo ./dependencies.sh --64
```

Must open a new terminal because the dependencies are recently installed and golang is needed to build the open-ethereum-pool.After opening the new terminal. One thing need to be carefully checked the configs in the [configuration.sh][config] according to your pool. 

```sh
$ sudo ./configuration.sh
```

Wait for the building of the project to be complete and when it will complete it will run the open-ethereum-pool then open a new terminal and run the front end without sudo

```sh
$ ./frontend.sh
```

Reply with y if prompted

The script works under my environment when no dependencies are installed and geth is not synced. However, it can still be improved and under development.

   [repo]: <https://github.com/sammy007/open-ethereum-pool>
   [www]: <https://github.com/sammy007/open-ethereum-pool/tree/master/www>
   [config]: <https://github.com/HamzaAnis/open-eth-pool-script-install/blob/master/configuration.sh#L14>
