// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the ERC20 and Ownable contracts from the OpenZeppelin library
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Define the ERC20Token contract and inherit functionality from OpenZeppelin ERC20 and Ownable
contract ERC20Token is ERC20, Ownable {
    // Constructor function to initialize the token with an initial supply
    constructor(uint256 initialSupply) ERC20("ERC20Token", "ERC") {
        // Mint the initial supply of tokens to the deployer (msg.sender)
        _mint(msg.sender, initialSupply);
    }

    // Function to return the total supply of tokens
    function totalSupply() public view override returns (uint256) {
        return super.totalSupply();
    }

    // Function to get the balance of a specific account
    function balanceOf(address account) public view override returns (uint256) {
        return super.balanceOf(account);
    }

    // Function to transfer tokens from the caller's address to a recipient
    function transfer(
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        return super.transfer(recipient, amount);
    }

    // Function to approve a spender to spend tokens on behalf of the caller
    function approve(
        address spender,
        uint256 amount
    ) public override returns (bool) {
        return super.approve(spender, amount);
    }

    // Function to transfer tokens from one account to another using an allowance
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }

    // Function to get the remaining number of tokens that a spender is allowed to spend
    function allowance(
        address owner,
        address spender
    ) public view override returns (uint256) {
        return super.allowance(owner, spender);
    }
}
