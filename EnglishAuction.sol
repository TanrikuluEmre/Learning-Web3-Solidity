// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IERC721 {
    function safeTransferFrom(
        address from,
        address to,
        uint tokenId
    ) external;

    function transferFrom(
        address,
        address,
        uint
    ) external;
}

contract EnglishAuction {
    event Start();
    event Bid(address indexed sender, uint amount);
    event WithDraw(address indexed sender,uint amount);
    event End(address highestBidder,uint highestBid);
    IERC721 public immutable nft;
    uint public immutable nftId;

    address public immutable seller;
    uint32 public endAt;
    bool public started;
    bool public ended;

    address public highestBidder;
    uint public highestBid;
    mapping (address => uint) public bids;

    constructor(
        address _nft,
        uint _nftId,
        uint _startingBid
    ){
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external {
        require(msg.sender == seller,"only seller can start");
        require(!started,"already started.");

        started = true;
        endAt = uint32(block.timestamp + 60);
        nft.transferFrom(seller, address(this), nftId);
        emit Start();

    }
    
    function bid() external payable {

        require(started,"not started");
        require(block.timestamp < endAt,"ended");
        require(msg.value > highestBid,"lower than highestbid");
        if(highestBidder!=address(0)){
            bids[highestBidder] += highestBid;
        }
        highestBid = msg.value;
        highestBidder = msg.sender;
        emit Bid(msg.sender, msg.value);

    }
    
    function withDraw() external {
        uint balance = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
        emit WithDraw(msg.sender,balance);
    }

    function end() external {
        require(started,"not started");
        require(!   ended,"ended");
        require(block.timestamp >= endAt,"not ended");

        ended = true;
        if(highestBidder != address(0)){
        
        nft.transferFrom(address(this), highestBidder, nftId);
        payable(seller).transfer(highestBid);
        
        }
        nft.transferFrom(address(this),seller,nftId); 
        emit End(highestBidder,highestBid);
        
    }

}
