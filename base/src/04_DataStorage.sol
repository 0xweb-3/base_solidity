// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract DataStorage {
    uint[] public  x = [1, 2, 3];

    function fStorage() public {
        uint[] storage xStorage = x;
        xStorage[0]= 1024;
    }

    function fMemory () public  view {
        uint[] memory xMemory = x;
        xMemory[0] = 100;
        xMemory[1] = 200;
        uint[] memory xMemory2 = x;
        xMemory2[0] = 300;
    }
    function fCalldata(uint[] calldata _x) public pure returns (uint[] calldata) {
        // 参数为calldata数组，不能被修改
        // _x[0] = 1024;

        return (_x);
    }

} 