// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importing OpenZeppelin's ERC721 and Ownable contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Define the ERC721Token contract, inheriting from ERC721, ERC721Enumerable, ERC721URIStorage, and Ownable
contract ERC721Token is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter; // Using the Counters library for counters

    Counters.Counter private _tokenIdCounter; // Counter to keep track of token IDs

    // Constructor to initialize the token with a name and symbol
    constructor() ERC721("MyNFT", "NFT") {}

    // Function to mint a new token
    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current(); // Get the current token ID
        _tokenIdCounter.increment(); // Increment the token ID counter
        _safeMint(to, tokenId); // Mint the token to the specified address
        _setTokenURI(tokenId, uri); // Set the token URI for metadata
    }

    // Function to return the base URI for all tokens
    function _baseURI() internal view virtual override returns (string memory) {
        return "https://api.example.com/metadata/";
    }

    // Function to burn a token, removing it from circulation
    function _burn(
        uint256 tokenId
    ) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    // Function to get the token URI for a specific token ID
    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    // Function to support interface detection (required by ERC721Enumerable)
    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    // Function to handle before token transfer logic (required by ERC721Enumerable)
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}
