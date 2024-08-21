// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Events} from "../src/07.Events.sol";

// forge script  ./script/07.Event.s.sol --rpc-url=$ETH_RPC_URL --private-key=$PRIVATE_KEY --broadcast -vvv
// cast send --rpc-url=$ETH_RPC_URL --private-key=$PRIVATE_KEY 0x6F10c17c8d72DA29B19d10E1Cc44810160C8A223 "_transfer(address,address,uint256)" 0x8ff44C9b5Eab5E5CE8d1d642184b70e9b9587F74 0x8ff44C9b5Eab5E5CE8d1d642184b70e9b9587F74 1024
contract EventsScript is Script {
    Events public events;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        events = new Events();

        vm.stopBroadcast();
    }
}
