Description:
The Crowdfunding contract (Solidity 0.8.20) enables decentralized crowdfunding on Ethereum's Sepolia testnet. Users contribute ETH before a deadline, tracked via contributions. If the fundingGoal is met, the owner withdraws funds; otherwise, contributors can refund. Events log contributions and withdrawals, ensuring transparency for secure crowdfunding.

Crowdfunding: Decentralized Crowdfunding Platform
The Crowdfunding contract is a secure, decentralized crowdfunding platform built with Solidity (0.8.20) for Ethereum, deployed on Sepolia. It allows users to contribute ETH toward a funding goal within a set deadline. The owner withdraws funds if the goal is met; otherwise, contributors can claim refunds.

🚀 Features:
ETH Contributions: Users send ETH to fund the campaign before the deadline.
Funding Goal Tracking: Monitors totalContributed against fundingGoal.
Refunds: Contributors can reclaim ETH if the goal isn’t reached post-deadline.
Owner Withdrawal: Owner can withdraw funds post-deadline if the goal is met, only once.
Transparency: Logs contributions (ContributionReceived) and withdrawals (FundsWithdrawn).
Individual Tracking: Tracks each contributor’s ETH via contributions mapping.
Sepolia Deployment: Runs on Sepolia testnet for safe testing.

🛠 Smart Contract Functions:
constructor(uint _durationInMinutes, uint _fundingGoalInEther): Sets owner, deadline, and funding goal (in ETH).
contribute() payable: Accepts ETH contributions before deadline, tracks amounts, and updates goalReached.
withdrawFunds(): Allows owner to withdraw funds post-deadline if goal is met, restricted to once.
refund(): Refunds contributors post-deadline if goal isn’t met, resetting their contribution.
Events: ContributionReceived(address contributor, uint amount): Logs contributions.
FundsWithdrawn(address owner, uint amount): Logs owner withdrawals.

🔒 Security Measures:
Access Control: onlyOwner modifier restricts withdrawals to the contract owner.
Time Constraints: beforeDeadline and afterDeadline modifiers enforce contribution and withdrawal timing.
Single Withdrawal: fundsWithdrawn prevents multiple owner withdrawals.
Safe Transfers: Uses call with checks for secure ETH transfers, reverting on failure.
Environment Security: .env files (e.g., private keys, API keys) are excluded via .gitignore.
Verification: Deployed on Sepolia, verifiable on Etherscan for transparency.
Safe Math: Solidity 0.8.20 ensures overflow protection.

🏗 Setup:
Hardhat
MetaMask (Sepolia-configured)
Sepolia ETH (https://sepoliafaucet.com)
Alchemy account

Testing:
Contribute ETH with contribute before the deadline.
Check totalContributed and goalReached via contract calls.
Withdraw funds with withdrawFunds (owner, post-deadline, goal met).
Refund with refund (post-deadline, goal not met).
Monitor events on Etherscan.

📍 Live Deployment:
Contract: Deploy on Sepolia.
Etherscan: Verify at https://sepolia.etherscan.io/address/

📜 License
MIT License
Powered by Sepolia testnet and Alchemy.

