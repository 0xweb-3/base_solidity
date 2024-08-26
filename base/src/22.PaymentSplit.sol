// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract PaymentSplit{
    // 事件
    event PayeeAdded(address account, uint256 shares); // 增加受益人事件
    event PaymentReleased(address to, uint256 amount); // 受益人提款事件
    event PaymentReceived(address from, uint256 amount); // 合约收款事件

    uint256 public totalShares; // 总份额
    uint256 public totalReleased; // 总支付

    mapping(address => uint256) public shares; // 每个受益人的份额
    mapping(address => uint256) public released; // 支付给每个受益人的金额
    address[] public payees; // 受益人数组

    // 构造函数：始化受益人数组_payees和分账份额数组_shares，其中数组长度不能为0，
    // 两个数组长度要相等。_shares中元素要大于0，_payees中地址不能为0地址且不能有重复地址。
    constructor(address[] memory _payees, uint256[] memory _shares) payable {
        // 检查_payees和_shares数组长度相同，且不为0
        require(_payees.length == _shares.length, "PaymentSplitter: payees and shares length mismatch");
        require(_payees.length > 0, "PaymentSplitter: no payees");
        // 调用_addPayee，更新受益人地址payees、受益人份额shares和总份额totalShares
        for (uint256 i = 0; i < _payees.length; i++) {
            _addPayee(_payees[i], _shares[i]);
        }
    }

    // 在分账合约收到ETH时触发PaymentReceived事件。
    receive() external payable {
        emit PaymentReceived(msg.sender, msg.value);
    }


    // release()：分账函数，为有效受益人地址_account分配相应的ETH。
    // 任何人都可以触发这个函数，但ETH会转给受益人地址account。调用了releasable()函数。
    function release(address payable _account) public {
        // account必须是有效受益人
        require(shares[_account] > 0, "PaymentSplitter: account has no shares");
        // 计算account应得的eth
        uint256 payment = releasable(_account);
        // 应得的eth不能为0
        require(payment != 0, "PaymentSplitter: account is not due payment");
        // 更新总支付totalReleased和支付给每个受益人的金额released
        totalReleased += payment;
        released[_account] += payment;
        // 转账
        _account.transfer(payment);
        emit PaymentReleased(_account, payment);
    }

    // releasable()：计算一个受益人地址应领取的ETH。调用了pendingPayment()函数。
    function releasable(address _account) public view returns (uint256) {
        // 计算分账合约总收入totalReceived
        uint256 totalReceived = address(this).balance + totalReleased;
        // 调用_pendingPayment计算account应得的ETH
        return pendingPayment(_account, totalReceived, released[_account]);
    }

    // pendingPayment()：根据受益人地址_account, 分账合约总收入_totalReceived和该地址已领取的钱_alreadyReleased，计算该受益人现在应分的ETH。
        function pendingPayment(
        address _account,
        uint256 _totalReceived,
        uint256 _alreadyReleased
    ) public view returns (uint256) {
        // account应得的ETH = 总应得ETH - 已领到的ETH
        return (_totalReceived * shares[_account]) / totalShares - _alreadyReleased;
    }

    // _addPayee()：新增受益人函数及其份额函数。在合约初始化的时候被调用，之后不能修改。
    function _addPayee(address _account, uint256 _accountShares) private {
        // 检查0地址
        require(_account != address(0), "PaymentSplitter: account is the zero address");
        // 检查_accountShares不为0
        require(_accountShares > 0, "PaymentSplitter: shares are 0");
        //  检查_account不重复
        require(shares[_account] == 0, "PaymentSplitter: account already has shares");
        //  更新payees，shares和totalShares
        payees.push(_account);
        shares[_account] = _accountShares;
        totalShares += _accountShares;
        // 触发增加受益人事件
        emit PayeeAdded(_account, _accountShares);
    }
}