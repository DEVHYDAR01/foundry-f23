// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";

contract DeployFundme is Script{
    function run() external returns(FundMe) {
        FundMe fundMe;
        HelperConfig helperConfig = new HelperConfig();
        address ethPriceFeed = helperConfig.activeNetworkConfig();
        vm.startBroadcast();
        fundMe = new FundMe(ethPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}