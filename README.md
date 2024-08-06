# Foundy DeFi Stablecoin

This is a section of the Cyfrin foundry Solidity Course.

# About

This project is meant to be a stablecoin where users can deposit WETH abd WBTC in exchange for a token that will be pegged to the USD.

# Getting Started

## Requirements
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [foundry](https://getfoundry.sh/)

## Quickstart

```
git clone https://github.com/mgomes-d/defi_stablecoin
cd defi_stablecoin
make install
forge build
```

# Usage

## Start a local

```
anvil
```

## Deploy

This will default to your local node. You need to have it runing in another terminal in order for it to deploy.
```
make deploy
```

## Testing 

In this repo there 3 types of test.

Unit, Integration and fuzzing.

```
forge test
```

### Test Coverage

```
forge coverage
```
and for coverage based testing:
```
forge coverage --report debug
```

# Deployment to a testnet or mainnet

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.

1. Get testnet ETH

Go to this site [faucets.chain.link](https://faucets.chain.link/) to get testnet ETH.

2. Deploy

```
forge script script/DeployDSC.s.sol:DeployDSC --rpc-url <SEPOLIA_RPC_URL> --private-key <PRIVATE KEY> --broadcast
```
If you're using a mainnet use a keystore
- How to use:
  - To create a new account, open a new terminal, not in vscode (for security reason).
    ```
    cast wallet import accountName --interactive
    ```
    Past yout private-key and enter a password.
    By default, the account will be stored at ~/.foundry/keystores
  
  - To check all yours accounts:
    ```
    cast wallet list
    ```

    For more informations about the [wallet commands](https://book.getfoundry.sh/reference/cast/wallet-commands).

Now you can use this command to deploy more safely
```
forge script script/DeployDSC.s.sol:DeployDSC --rpc-url <SEPOLIA_RPC_URL> --account <accountName> --broadcast
```

## Scripts 

Instead of scripts, we can directly use the `cast` command to interact with the contract.

For example, on Sepolia:

1. Get WETH

```
cast send 0xdd13E55209Fd76AfE204dBda4007C227904f0a81 "deposit()" --value 0.1ether --rpc-url<SEPOLIA_RPC_URL> --account <SEPOLIA_ACCOUNT>
```

2. Approve the WETH

```
cast send 0xdd13E55209Fd76AfE204dBda4007C227904f0a81 "approve(address,uint256)" <Your contract address> 1000000000000000000 --rpc-url <$SEPOLIA_RPC_URL> --account <SEPOLIA_ACCOUNT>
```

3. Deposit and Mint DSC

```
cast send <CONTRACT ADDRESS> "depositCollateralAndMintDsc(address,uint256,uint256)" 0xdd13E55209Fd76AfE204dBda4007C227904f0a81 100000000000000000 10000000000000000 --rpc-url <SEPOLIA_RPC_URL> --account <SEPOLIA_ACCOUNT>
```

## Estimate gas

You can estimate how much gas things cost by running:
```
forge snapshot
```
and there a output file called `.gas-snapshot` 
