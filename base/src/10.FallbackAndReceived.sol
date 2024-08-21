// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract FallbackAndReceived {
        /* 触发fallback() 还是 receive()?
           接收ETH
              |
         msg.data是空？
            /  \
          是    否
          /      \
receive()存在?   fallback()
        / \
       是  否
      /     \
receive()  fallback   
    */

    // 定义事件
    event receivedCalled(address indexed Sender, uint Value);
    event fallbackCalled(address indexed Sender, uint Value, bytes Data);

    // 接收ETH时触发Received事件
    receive() external payable {
        emit receivedCalled(msg.sender, msg.value);
    }

    // fallback
    fallback() external payable {
        if (msg.value > 0) {
            emit receivedCalled(msg.sender, msg.value);
        } else {
            emit fallbackCalled(msg.sender, msg.value, msg.data);
        }
    }
}