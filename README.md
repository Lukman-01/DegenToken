# DegenToken

This Solidity program implements the `DegenToken` smart contract, an ERC20 token with burnable functionality. The contract includes features for minting new tokens, transferring tokens between accounts, redeeming tokens for rewards, and burning tokens. This project demonstrates the use of OpenZeppelin libraries for secure and standardized contract development.

## Description

The `DegenToken` contract is built on the Ethereum blockchain using Solidity. It leverages OpenZeppelin's ERC20, ERC20Burnable, and Ownable contracts to provide a robust token with additional functionalities:
- **Minting**: Only the contract owner can mint new tokens.
- **Transferring**: Users can transfer tokens to others.
- **Redeeming**: Users can redeem tokens for predefined rewards.
- **Burning**: Users can burn (destroy) their tokens.

This project includes a Hardhat setup for deploying and testing the smart contract on the Avalanche network (both mainnet and testnet).

## Getting Started

### Prerequisites

- Node.js
- npm (Node Package Manager)
- Hardhat
- An Avalanche wallet with testnet or mainnet funds
- `.env` file with your private key and Snowtrace API key

### Setting Up the Project

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Lukman-01/DegenToken.git
   cd DegenToken
   ```

2. **Install Dependencies**

   ```bash
   npm install
   ```

3. **Create a `.env` File**

   Create a `.env` file in the root directory with the following content:

   ```bash
   WALLET_PRIVATE_KEY=your_private_key
   SNOWTRACE_API_KEY=your_snowtrace_api_key
   ```

### Executing the Program

1. **Compile the Contract**

   ```bash
   npx hardhat compile
   ```

2. **Deploy the Contract**

   You can deploy the contract to the Avalanche Fuji testnet or mainnet by running the appropriate Hardhat task.

   **Deploy to Fuji Testnet:**

   ```bash
   npx hardhat run scripts/deploy.js --network fuji
   ```

   **Deploy to Mainnet:**

   ```bash
   npx hardhat run scripts/deploy.js --network mainnet
   ```

3. **Interact with the Contract**

   You can interact with the deployed contract using Hardhat tasks or through a frontend interface that connects to the Avalanche network. Below is an example of how to mint new tokens:

   ```bash
   npx hardhat mint --recipient <recipient_address> --quantity <amount> --network <network_name>
   ```

### Authors
Abdulyekeen Lukman
