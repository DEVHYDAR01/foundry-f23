// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AggregatorV3Interface} from "../lib/chainlink-brownie-contracts/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

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

library PriceConverter {
    function getPriceFeed(AggregatorV3Interface priceFeed) internal view returns (uint256) {
        (, int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer * 10000000000);
    }

    function getConversionRate(uint256 ethAmount, AggregatorV3Interface priceFeed) internal view returns (uint256) {
        uint256 ethPrice = getPriceFeed(priceFeed);
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface version;
        return version.version();
    }
}
