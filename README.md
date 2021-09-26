# Wave Portal Backend

Send me a hello through the blockchain!

This is my project for the course [Build a Web3 App with Solidity + Ethereum Smart Contracts](https://buildspace.so/solidity) at [Buildspace](https://buildspace.so/).

Check the frontend code at https://github.com/fmoliveira/wave-portal-frontend

## Prerequisites

- Node.js v14+

## Getting started

Follow the steps below to run the project locally:

- Install dependencies: `npm install`
- List test accounts from your local hardhat node: `npx hardhat accounts`
- Compile smart contracts: `npx hardhat compile`
- Test contract: `npx hardhat run scripts/run.js`

### Local deployment

- Start your local hardhat node: `npx hardhat node`
- Deploy contract to local hardhat node: `npx hardhat run scripts/deploy.js --network localhost`

### Testnet deployment

- Deploy contract to rinkeby testnet: `npx hardhat run scripts/deploy.js --network rinkeby`
