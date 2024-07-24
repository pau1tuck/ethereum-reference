// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importing OpenZeppelin's Ownable and ERC20 contracts
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Define the Crowdsale contract, inheriting from Ownable
contract Crowdsale is Ownable {
    ERC20 public token; // The token being sold
    address payable public wallet; // Address where collected funds will be forwarded
    uint256 public rate; // How many token units a buyer gets per wei
    uint256 public weiRaised; // Amount of wei raised

    // Event to log when tokens are purchased
    event TokensPurchased(
        address indexed purchaser,
        address indexed beneficiary,
        uint256 value,
        uint256 amount
    );

    // Constructor to initialize the contract
    constructor(
        uint256 _rate,
        address payable _wallet,
        ERC20 _token
    ) Ownable() {
        require(_rate > 0, "Rate must be greater than 0");
        require(_wallet != address(0), "Wallet address cannot be 0");
        require(address(_token) != address(0), "Token address cannot be 0");

        rate = _rate; // Set the rate of tokens per wei
        wallet = _wallet; // Set the wallet address
        token = _token; // Set the token address

        transferOwnership(msg.sender); // Set the initial owner of the contract
    }

    // Fallback function to receive ether
    receive() external payable {
        buyTokens(msg.sender);
    }

    // Function to buy tokens
    function buyTokens(address beneficiary) public payable {
        uint256 weiAmount = msg.value; // Calculate the wei amount
        _preValidatePurchase(beneficiary, weiAmount); // Validate the purchase

        uint256 tokens = _getTokenAmount(weiAmount); // Calculate the number of tokens to be created
        weiRaised += weiAmount; // Update the amount of wei raised

        _processPurchase(beneficiary, tokens); // Process the token purchase
        emit TokensPurchased(msg.sender, beneficiary, weiAmount, tokens); // Emit the TokensPurchased event

        _updatePurchasingState(beneficiary, weiAmount); // Update purchasing state

        _forwardFunds(); // Forward the funds to the wallet
        _postValidatePurchase(beneficiary, weiAmount); // Validate after the purchase
    }

    // Function to validate purchase before processing
    function _preValidatePurchase(
        address beneficiary,
        uint256 weiAmount
    ) internal view {
        require(beneficiary != address(0), "Beneficiary address cannot be 0");
        require(weiAmount != 0, "Wei amount cannot be 0");
    }

    // Function to validate purchase after processing
    function _postValidatePurchase(
        address beneficiary,
        uint256 weiAmount
    ) internal view {
        // Optional: Implement post-validation logic if needed
    }

    // Function to deliver tokens to the purchaser
    function _deliverTokens(address beneficiary, uint256 tokenAmount) internal {
        token.transfer(beneficiary, tokenAmount); // Transfer the tokens
    }

    // Function to process the token purchase
    function _processPurchase(
        address beneficiary,
        uint256 tokenAmount
    ) internal {
        _deliverTokens(beneficiary, tokenAmount); // Deliver the tokens
    }

    // Function to update the purchasing state
    function _updatePurchasingState(
        address beneficiary,
        uint256 weiAmount
    ) internal {
        // Optional: Implement state updates if needed
    }

    // Function to get the number of tokens from wei amount
    function _getTokenAmount(
        uint256 weiAmount
    ) internal view returns (uint256) {
        return weiAmount * rate; // Calculate token amount based on rate
    }

    // Function to forward the funds to the wallet
    function _forwardFunds() internal {
        wallet.transfer(msg.value); // Transfer the ether to the wallet
    }
}
