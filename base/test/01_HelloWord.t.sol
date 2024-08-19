// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {HelloWord} from "../src/01_HelloWord.sol";

// forge clean && forge build
// forge test --match-path ./test/01_HelloWord.t.sol -vvv
contract HelloWordTest is Test {
    HelloWord public helloWord;

    function setUp() public {
        helloWord = new HelloWord();
    }

    function test_HelloWordString() view public {
        string memory helloWorldStr =  helloWord.getHelloWorld();
        console2.log(helloWorldStr);
    }
}
