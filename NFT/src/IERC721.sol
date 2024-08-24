// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./IERC165.sol";

interface IERC721 is IERC165 {
    // 在转账时被释放，记录代币的发出地址from，接收地址to和tokenid。
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    // 在授权时释放，记录授权地址owner，被授权地址approved和tokenid。
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    // 在批量授权时释放，记录批量授权的发出地址owner，被授权地址operator和授权与否的approved。
    event ApprovalAll(address indexed owner, address indexed operator, bool approved);

    // 返回某地址的NFT持有量balance
    function balanceOf(address owner) external view returns (uint256 balance);
    // 返回某tokenId的主人owner
    function ownerOf(uint256 tokenId) external view returns (address owner);
    // 普通转账，参数为转出地址from，接收地址to和tokenId
    function TransferFrom(address from, address to, uint256 tokenId) external;
    // 安全转账（如果接收方是合约地址，会要求实现ERC721Receiver接口）。参数为转出地址from，接收地址to和tokenId
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    // 授权另一个地址使用你的NFT。参数为被授权地址approve和tokenId。
    function approve(address to, uint256 tokenId) external;
    // 查询tokenId被批准给了哪个地址。
    function getApproved(uint256 tokenId) external view returns (address operator); 
    // 将自己持有的该系列NFT批量授权给某个地址operator。
    function setApprovalForAll(address operator, bool _approved) external;
    // 查询某地址的NFT是否批量授权给了另一个operator地址。
    function isApprovedForAll(address owner, address operator) external view returns (bool);
    // 安全转账的重载函数，参数里面包含了data。
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;
}