// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Deposit Ether
// Users should be able to send Ether to the contract.
// Store each user’s balance.
// Withdraw Ether
// Users should be able to withdraw only up to the amount they deposited.
// Prevent users from withdrawing more than their balance.
// Check Balance
// Add a function so any user can check their own balance.
// Events
// Emit an event whenever a deposit or withdrawal happens.

contract SimpleBankContract {
    mapping (address => uint) public userToBalance;
    address[] funders;
    address public immutable owner;
    
    constructor () {
        owner = msg.sender;
    }

    function deposit() public payable {
        userToBalance[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function withdraw(address _useraddr, uint256 _amount) public {
        uint256 amountDeposited = userToBalance[_useraddr];
        require(_amount <= amountDeposited, "You can't withdraw more than you deposited");

        // Update state before transferring funds to prevent reentrancy
        userToBalance[_useraddr] -= _amount;
        require(address(this).balance >= _amount, "Not enough balance in contract");

        // Transfer funds after updating the state
        (bool Success, ) = payable(_useraddr).call{value: _amount}("");
        require(Success, "Call failed");
    }

    function checkBalance() public view returns (uint256) {
        return userToBalance[msg.sender];  // Returns the balance of the caller
    }

    function totalBankEth() public view returns (uint256) {
        return address(this).balance;
    }
}
