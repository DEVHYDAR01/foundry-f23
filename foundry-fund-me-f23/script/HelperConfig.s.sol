//SPDX-License-Identifier: MIT
//if we are on local anvil, we deply mocks
//otherwise, grab the existing address from the live network
pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";

contract HelperConfig is Script{
    NetworkConfig public activeNetworkConfig;

    constructor () {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaConfig();
        }
        // else {
        //     activeNetworkConfig = getAnvilConfig();
        // }
    }

    struct NetworkConfig {
        address priceFeed;
    }

    function getSepoliaConfig() public pure returns(NetworkConfig memory){
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function getAnvilConfig() public returns(NetworkConfig memory) {
    }
}

