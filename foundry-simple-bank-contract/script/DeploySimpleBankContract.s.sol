// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {SimpleBankContract} from "../src/SimpleBankContract.sol";

contract DeploySimpleBankContract is Script {
    function run() external {
        vm.startBroadcast();
        SimpleBankContract simplebankcontract = new SimpleBankContract();
        vm.stopBroadcast();
    }
}
