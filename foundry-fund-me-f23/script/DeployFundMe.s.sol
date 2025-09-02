// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract DeployFundme is Script{
    function run() external {
        FundMe fundme;
        vm.startBroadcast();
        fundme = new FundMe();
        vm.stopBroadcast();
    }
}