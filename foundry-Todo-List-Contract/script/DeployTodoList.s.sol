// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {TodoListContract} from "../src/TodoListContract.sol";


contract DeployTodoList is Script {
    function run() external {
        vm.startBroadcast();
        TodoListContract todolistcontract = new TodoListContract();
        vm.stopBroadcast();
    }
}