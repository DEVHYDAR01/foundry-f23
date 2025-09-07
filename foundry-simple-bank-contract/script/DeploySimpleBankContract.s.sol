// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {SimpleBankContract} from "../src/SimpleBankContract.sol";
import {AggregatorV3Interface} from "../lib/chainlink-brownie-contracts/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract DeploySimpleBankContract is Script {
    function run() external {
        AggregatorV3Interface priceFeed;
        vm.startBroadcast();
        SimpleBankContract simplebankcontract = new SimpleBankContract();
        vm.stopBroadcast();
    }
}