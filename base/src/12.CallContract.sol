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


contract CallContract{
    // 传入合约地址
    function callSetX(address _address, uint256 _x) external {
        OtherContract(_address).setX(_x);
    }

    // 传入合约变量
    function callGetX(OtherContract _address) external view returns(uint x){
        x = _address.getX();
    }

    // 创建合约变量
    function callGetX2(address _address) external view returns(uint x){
        OtherContract oc = OtherContract(_address);
        x = oc.getX();
    }

    // 调用合约并发送
     function setXTransferETH(address _address, uint256 x) payable external{
        OtherContract(_address).setX{value: msg.value}(x);
    }
}
