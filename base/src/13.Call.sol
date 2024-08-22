// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract OtherContract {
    uint256 private _x = 0; // 状态变量x
    // 收到eth事件，记录amount和gas
    event Log(uint amount, uint gas);
    
    // 返回合约ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable{
        _x = x;
        // 如果转入ETH，则释放Log事件
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }

    // 读取x
    function getX() external view returns(uint x){
        x = _x;
    }
}

contract Call {
    event Response(bool success, bytes data);

    function callSetX(address payable _addr, uint256 x) public payable {
       (bool success, bytes memory data) = _addr.call{value: msg.value}(abi.encodeWithSignature("setX(uint256)", x));
        emit Response(success, data);
    }

    function callGetX(address _addr) external returns (uint256) {
        (bool success, bytes memory data) = _addr.call(abi.encodeWithSignature("getX()"));

        emit Response(success, data); 
        return abi.decode(data, (uint256));
    }

    function callNonExist(address _addr) external {
        (bool success, bytes memory data) = _addr.call(abi.encodeWithSignature("foo(uint256)"));
        emit Response(success, data);
    }
}