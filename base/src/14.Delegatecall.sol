// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract A {
    uint public num;
    address public sender;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
    }
}

contract B {
    uint public num;
    address public sender;

    event callEvent(bool success, bytes data);

    // 通过call来调用C的setVars()函数，将改变合约A里的状态变量
    function callSetVars(address _addr, uint _num) external  payable {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        emit callEvent(success, data);
    }

    //  通过delegatecall来调用A的setVars()函数，将改变合约B里的状态变量
    function delegatecallSetVars(address _addr, uint _num) external payable{
        (bool success, bytes memory data) = _addr.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        emit callEvent(success, data);
    }
}
