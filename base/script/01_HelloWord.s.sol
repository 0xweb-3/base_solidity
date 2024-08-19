// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {HelloWord} from "../src/01_HelloWord.sol";

contract CounterScript is Script {
    HelloWord public helloWord;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        helloWord = new HelloWord();

        vm.stopBroadcast();
    }
}
