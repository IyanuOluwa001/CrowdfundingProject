VotingContract: Decentralized Voting System
Welcome to the VotingContract, a decentralized voting system built on Ethereum using Solidity (0.8.2–0.9.0). Designed for secure, token-based governance, it allows token holders to vote on proposals with a one-vote-per-address rule. Deployed on the Sepolia testnet, this contract ensures transparency and integrity in voting processes, ideal for DAOs or community governance.

🚀 Features:
Token-Based Voting: Only token holders can vote, enforced by the onlyTokenHolders modifier.
One Vote Per Address: Prevents double voting using the hasVoted mapping.
Proposal Voting: Tracks votes per proposal via proposalVotes.
Transparency: Emits VoteCast events for each vote.
Eligibility Check: checkEligibility verifies voter token balance.
Vote Counting: getVotes returns total votes for a proposal.
Token Management: Owner can mint tokens via addTokens.

🛠 Smart Contract Functions:
constructor(): Initializes the contract, minting 100 tokens to the deployer.
addTokens(address user, uint256 amount): Mints tokens to a user (owner-only).
vote(uint proposalId): Casts a vote for a proposal, restricted to token holders who haven’t voted.
getVotes(uint proposalId): Returns the vote count for a proposal.
checkEligibility(address voter): Checks if an address holds tokens and can vote.
Event: VoteCast(address voter, uint proposalId) logs each vote.

🔒 Security Measures:
Access Control: onlyTokenHolders modifier ensures only token holders vote.
Vote Integrity: hasVoted prevents double voting.
Owner Privileges: Only the owner can mint tokens via addTokens.
Environment Security: .env files with private keys and API keys are excluded via .gitignore.
Contract Verification: Deployed on Sepolia and verifiable on Etherscan.
Safe Design: Uses Solidity’s safe math and explicit checks to prevent overflows.

🏗 Setup and Installation

Prerequisites:
MetaMask (configured for Sepolia)
Sepolia ETH (from https://sepoliafaucet.com)
Alchemy account (for RPC)

Testing:
Mint Tokens: Use addTokens to distribute tokens to test accounts.
Vote: Call vote with a proposalId using a token-holding account.
Check Votes: Use getVotes to verify vote counts.
Eligibility: Test checkEligibility for voter status.
Events: Monitor VoteCast events on Etherscan or a frontend.

📜 License:
MIT License.
