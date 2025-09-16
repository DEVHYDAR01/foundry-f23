// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "../lib/chainlink-brownie-contracts/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

contract SimpleBankContract {
    mapping(address => uint256) public userToBalance;
    address public immutable I_OWNER;
    uint256 ethAmount;
    event Log(address indexed sender, string message);
    uint256 public constant MINIMUM_USD = 5e18;
    using PriceConverter for uint256;
    AggregatorV3Interface private s_priceFeed;

    constructor(address priceFeed) {
        I_OWNER = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    function deposit() public payable depoOrwithEvent {
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "You need to spend more ETH!");
        userToBalance[msg.sender] += msg.value;
    }

    function withdraw(address _useraddr, uint256 _amount) public depoOrwithEvent {
        uint256 amountDeposited = userToBalance[_useraddr];
        require(_amount <= amountDeposited, "You can't withdraw more than you deposited");

        // Update state before transferring funds to prevent reentrancy
        userToBalance[_useraddr] -= _amount;
        require(address(this).balance >= _amount, "Not enough balance in contract");

        // Transfer funds after updating the state
        (bool Success,) = payable(_useraddr).call{value: _amount}("");
        require(Success, "Call failed");
    }

    function checkBalance() public view returns (uint256) {
        return userToBalance[msg.sender]; // Returns the balance of the caller
    }

    function totalBankEth() public view returns (uint256) {
        return address(this).balance;
    }

    modifier depoOrwithEvent() {
        emit Log(msg.sender, "Ether has been deposited or withdrawed");
        _;
    }
}

fallback() {
    deposit();
}
receive() {
    deposit();
}
