// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract VotingContract{
    address public owner;
    mapping(address => uint256) public tokenBalance;
    mapping(uint => uint) public proposalVotes;
    mapping(address => bool) public hasVoted;

event VoteCast(address indexed voter, uint proposalId);
    modifier onlyTokenHolders() {
    require(tokenBalance[msg.sender] > 0, "You must hold tokens to vote.");
    _;
}

constructor() {
    owner = msg.sender;

    // Mint initial tokens to the deployer
    tokenBalance[msg.sender] = 100;
}
    
    function addTokens(address user, uint256 amount) public {
        require(msg.sender == owner, "Only owner can mint tokens.");
        tokenBalance[user] += amount;
}

    function vote(uint proposalId) public onlyTokenHolders {
        require(!hasVoted[msg.sender], "You have already voted.");

    proposalVotes[proposalId] += 1;
    hasVoted[msg.sender] = true;

    emit VoteCast(msg.sender, proposalId);
}

    function getVotes(uint proposalId) public view returns (uint) {
        return proposalVotes[proposalId];
}

    function checkEligibility(address voter) public view returns (bool) {
        return tokenBalance[voter] > 0;
}
}