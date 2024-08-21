// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Overload {
    function saySomthing() public  pure returns (string memory) {
        return  "Nothing";
    }

    function saySomthing(string memory _msg) public  pure returns (string memory) {
        return _msg;
    }

    function f(uint8 _in) public pure returns (uint8) {
        return _in;
    }

    // 在调用时明确使用想过类型可区分不同函数
    function f(uint256 _in) public pure returns (uint256) {
        return _in;
    }
}