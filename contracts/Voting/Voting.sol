// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importing OpenZeppelin's Ownable contract
import "@openzeppelin/contracts/access/Ownable.sol";

// Define the VotingContract, inheriting from Ownable
contract VotingContract is Ownable {
    // Struct to represent a candidate
    struct Candidate {
        uint id; // Candidate ID
        string name; // Candidate's name
        uint voteCount; // Number of votes the candidate has received
    }

    // Mapping to store voter addresses and track if they have voted
    mapping(address => bool) public voters;
    // Mapping to store candidate details by ID
    mapping(uint => Candidate) public candidates;
    // Variable to keep track of the total number of candidates
    uint public candidatesCount;

    // Event emitted when a vote is cast
    event VoteCast(address indexed voter, uint indexed candidateId);

    // The Ownable contract now requires an address as an argument for its constructor.
    // This address is set to the initial owner of the contract.
    constructor(string[] memory candidateNames) Ownable(msg.sender) {
        for (uint i = 0; i < candidateNames.length; i++) {
            addCandidate(candidateNames[i]);
        }
    }

    // Function to add a new candidate
    function addCandidate(string memory name) private {
        candidatesCount++; // Increment the candidate count
        candidates[candidatesCount] = Candidate(candidatesCount, name, 0); // Add the new candidate to the mapping
    }

    // Function to cast a vote
    function vote(uint candidateId) public {
        require(!voters[msg.sender], "You have already voted."); // Check that the voter hasn't already voted
        require(
            candidateId > 0 && candidateId <= candidatesCount,
            "Invalid candidate ID."
        ); // Check for a valid candidate ID

        voters[msg.sender] = true; // Record that the voter has voted
        candidates[candidateId].voteCount++; // Increment the candidate's vote count

        emit VoteCast(msg.sender, candidateId); // Emit the VoteCast event
    }

    // Function to get the details of a candidate by ID
    function getCandidate(
        uint candidateId
    ) public view returns (Candidate memory) {
        require(
            candidateId > 0 && candidateId <= candidatesCount,
            "Invalid candidate ID."
        ); // Check for a valid candidate ID
        return candidates[candidateId]; // Return the candidate's details
    }

    // Function to get the total number of votes a candidate has received
    function getVotes(uint candidateId) public view returns (uint) {
        require(
            candidateId > 0 && candidateId <= candidatesCount,
            "Invalid candidate ID."
        ); // Check for a valid candidate ID
        return candidates[candidateId].voteCount; // Return the candidate's vote count
    }
}
