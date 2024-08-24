// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


interface IERC721Metadata {
    // 返回代币名称。
    function name() external view returns (string memory);
    // 返回代币代号。
    function symbol() external view returns (string memory);
    // 通过tokenId查询metadata的链接url，ERC721特有的函数。
    function tokenURI(uint256 tokenId) external view returns (string memory); 

}