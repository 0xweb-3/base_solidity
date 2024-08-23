// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./IERC20.sol";

contract MyERC20 is IERC20{
    mapping (address=>uint256) public override balanceOf;
    mapping (address=>mapping(address=>uint256)) public override allowance;

    uint256 public override totalSupply; //代币总供给
    string public name; // 代币名称
    string public symbol; // 符号
    uint256 public decimals = 18; // 精度
    address public constant ZERO_ADDRESS = 0x0000000000000000000000000000000000000000;


    address public owner;

    modifier OnlyOwner {
        require(msg.sender == owner, "only owner");
        _;
    }

    modifier CheckBalanceOf(uint256 amount){
        require(balanceOf[msg.sender] >= amount, "not enough token balance");
        _;
    }

    // 在合约部署的时候实现合约名称和符号
    constructor(string memory _name, string memory _symbol) {
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
    }

    // 将代币从调用者转移到to地址
    function transfer(address to, uint256 amount) external override CheckBalanceOf(amount) returns (bool){
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    // 调用者账户给`spender`账户授权 `amount`数量代币。
    function approve(address spender, uint256 amount) external override CheckBalanceOf(amount) returns(bool){
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // 通过授权机制，从`from`账户向`to`账户转账`amount`数量代币。转账的部分会从调用者的`allowance`中扣除。
    function transferFrom(address from, address to, uint256 amount) external override returns(bool){
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    // 铸造代币，从 `0` 地址转账给 调用者地址
    function mint(uint amount)  external OnlyOwner {
        totalSupply += amount;
        balanceOf[msg.sender] += amount;
        emit Transfer(msg.sender, msg.sender, amount);
    }

    // 销毁代币，从 调用者地址
    // 这种写法有OEA对象的问题
    // function burn(uint amount) external {
    //     this.transfer(ZERO_ADDRESS, amount);
    // }

    // 销毁代币，从调用者地址
    function burn(uint256 amount) external CheckBalanceOf(amount) {
        totalSupply -= amount;
        balanceOf[msg.sender] -= amount;
        emit Transfer(msg.sender, ZERO_ADDRESS, amount);
    }


}