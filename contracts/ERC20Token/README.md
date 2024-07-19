# ERC20 Token Smart Contract

## Overview

Tokens are digital assets that are created, issued, and managed on blockchain platforms like Ethereum. They can represent a variety of assets, from digital shares and loyalty points to physical goods.

The ERC20 token standard is a popular standard for creating tokens on the Ethereum blockchain. It ensures compatibility with existing platforms and applications that support ERC20.

## Contract: ERC20Token.sol

The `ERC20Token.sol` file implements the standard ERC20 functions and events, including:

- `totalSupply()`: Returns the total supply of the token.
- `balanceOf(address account)`: Returns the balance of a specific account.
- `transfer(address recipient, uint256 amount)`: Transfers tokens from the caller to a specified recipient.
- `approve(address spender, uint256 amount)`: Approves another address to spend tokens on behalf of the caller.
- `transferFrom(address sender, address recipient, uint256 amount)`: Transfers tokens from one address to another using an allowance.
- `allowance(address owner, address spender)`: Returns the remaining number of tokens that a spender is allowed to spend on behalf of an owner.

## Deployment Script

The `deployERC20Token.ts` script is used to deploy the ERC20 token contract. It includes all the necessary steps to compile, deploy, and verify the contract on the blockchain.

## Tests

The `ERC20Token.spec.ts` file includes various tests to ensure the correctness of the ERC20 token implementation. These tests cover:

- Deployment and initial state verification
- Token transfers between accounts
- Approval and transferFrom functionalities
- Edge cases and failure scenarios

## How to Use

1. **Compile the Contract**:

   ```sh
   npx hardhat compile
   ```
