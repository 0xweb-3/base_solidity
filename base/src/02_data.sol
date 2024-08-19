// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract DataContract {
    bool public boolData = true;
    address payable public addressData;
    EnumData public language;

    // 枚举用于为uint分配名称
    enum EnumData {
        python,
        solidity,
        java,
        js
    }


    constructor (address payable _address) {
        addressData = _address;

        language = EnumData.java;
    }

    function getAddress() public view returns(address) {
        return addressData;
    }

    function getEnumDataTouint() public view returns(uint) {
        return uint(language);
    }
}
