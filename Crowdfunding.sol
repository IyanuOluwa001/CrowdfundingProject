//1. Input the license (This is usually in a comment form)
// SPDX-License-Identifier: MIT

//2. Input solidity version
pragma solidity ^0.8.20;

//3. Create the contract called Crowdfunding - where you will put all that is asked
contract Crowdfunding {

    //4. Store address of contract owner, declare other variables
    address public owner;
    uint public deadline;
    uint public fundingGoal;
    uint public totalContributed;

    //5. Check if totalContributed >= fundingGoal
    bool public goalReached;

    //6. Ensure the owner can only withdraw once
    bool public fundsWithdrawn;

    //7. Track how much Ether each user contributed
    mapping(address => uint) public contributions;

    //8. Logging contribution time
    event ContributionReceived(address indexed contributor, uint amount);
    //9. Log whenever the owner withdraws funds
    event FundsWithdrawn(address indexed owner, uint amount);

    //10. Constructor to set the deadline and funding goal & deployer becomes owner
    constructor(uint _durationInMinutes, uint _fundingGoalInEther) {
        owner = msg.sender;
        deadline = block.timestamp + (_durationInMinutes * 1 minutes);
        fundingGoal = _fundingGoalInEther;
    }

    //11. Modifiers - restrict onlyOwner to call the function
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    //12. Modifiers - ensure function runs before the deadline
    modifier beforeDeadline() {
        require(block.timestamp <= deadline, "Deadline has passed");
        _;
    }

    //13. Modifiers - ensure function runds after the deadline
    modifier afterDeadline() {
        require(block.timestamp > deadline, "Deadline not yet passed");
        _;
    }

    //14. Function to restrict contribution, ensures users send some amount of Ether
    function contribute() external payable beforeDeadline {
        require(msg.value > 0, "Contribution must be greater than zero");

        //15. Track individual and total contributions
        contributions[msg.sender] += msg.value;
        totalContributed += msg.value;

        //16. Set if total contributions reaches or exceed the goal & set as true
        if (totalContributed >= fundingGoal) {
            goalReached = true;
        }

        //17. Log the contribution event
        emit ContributionReceived(msg.sender, msg.value);
    }

    //18. Function to withdraw funds, ensure owner can only withdraw after deadline & goal is reached
    function withdrawFunds() external onlyOwner afterDeadline {
        require(goalReached, "Funding goal not reached");
        require(!fundsWithdrawn, "Funds already withdrawn");

        uint amount = address(this).balance;
        fundsWithdrawn = true;

        (bool success, ) = payable(owner).call{value: amount}("");
        if (!success) {
            revert("Withdrawal failed");
        }

        emit FundsWithdrawn(owner, amount);
    }

    //19. Function to refund original contributors, works after deadline, reset their contribution to 0
    function refund() external afterDeadline {
        require(!goalReached, "Goal was reached, cannot refund");
        uint amount = contributions[msg.sender];
        require(amount > 0, "No contribution to refund");

        
        contributions[msg.sender] = 0;

        //20. Transfer Ether and reverts if transfer if transfer fails
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        if (!success) {
            revert("Refund failed");
        }
    }
}
