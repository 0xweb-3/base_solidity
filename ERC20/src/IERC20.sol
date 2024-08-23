// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IERC20 {
    // 当 `value` 单位的货币从账户 (`from`) 转账到另一账户 (`to`)时.
    event Transfer(address indexed from, address indexed to, uint256 value);
    //  当 `value` 单位的货币从账户 (`owner`) 授权给另一账户 (`spender`)时.
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // 返回代币总供应量
    function totalSupply() external view returns(uint256);

    // 返回账户中的代币余额
    function balanceOf(address account) external view returns(uint256); 

    // 将代币从调用者转移到to地址
    function transfer(address to, uint256 amount) external returns (bool);

    // 返回`owner`账户授权给`spender`账户的额度，默认为0。
    function allowance(address owner, address spender) external view returns(uint256);

    // 调用者账户给`spender`账户授权 `amount`数量代币。
    function approve(address spender, uint256 amount) external returns(bool);

    // 通过授权机制，从`from`账户向`to`账户转账`amount`数量代币。转账的部分会从调用者的`allowance`中扣除。
    function transferFrom(address from, address to, uint256 amount) external returns(bool);
}

