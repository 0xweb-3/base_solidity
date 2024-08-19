// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract HelloWord {
    string public helloWorld = "hello world";

    function getHelloWorld() public view returns(string memory){
        return helloWorld;
    }
}
