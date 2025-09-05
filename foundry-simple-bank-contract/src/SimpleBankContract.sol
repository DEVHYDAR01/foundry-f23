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
    mapping (address => uint) userToBalance;
    function deposit() public payable {
        userToBalance[msg.sender] += msg.value;
    }

}
