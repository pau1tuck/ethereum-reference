// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BasicAuthControl is Ownable {
    // Create custom data type for item:
    struct Item {
        uint id;
        string name;
        uint price;
        address owner;
    }
    // Create an array to store each item using array index as identifier.
    Item[] private items; // This state variable persists across transactions on the blockchain.
    // Map the owner of each item to the store by item ID.
    mapping(uint => address) private itemToOwner;

    // Emit event (create blockchain log entry) when a new item is added; log item ID, name, price, and owner address.
    event ItemAdded(uint id, string name, uint price, address owner);
    // Emit event when an item is removed; log item ID,
    event ItemRemoved(uint id);

    function getItemCount() public view returns (uint) {
        return items.length;
    }
    function getItem(uint id) public view returns (Item memory) {
        require(id < items.length, "Item not found");
        return items[id];
    }
    function addItem(string memory name, uint price) public onlyOwner {
        uint id = items.length;
        items.push(Item(id, name, price));
        itemToOwner[id] = msg.sender;
        emit ItemAdded(id, name, price, msg.sender);
    }
    function removeItem(uint id) public onlyOwner {
        require(id < items.length, "Item not found");
        delete items[id];
        delete itemToOwner[id];
        emit ItemRemoved(id);
    }
}
