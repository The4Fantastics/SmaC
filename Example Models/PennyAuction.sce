pragma solidity ^0.4.24;

import "./ierc20token.sol";

contract PennyAuction {
    
    address seller;

    IERC20Token public token;
    uint256 public bidIncrement;
    uint256 public timeoutPeriod;
    uint256 public bidFee;

    uint256 public auctionEnd;

    address  public highBidder;
    mapping(address => uint256) public balanceOf;
    uint256 public highBid;

    constructor(
        IERC20Token _token,
        uint256 _bidIncrement,
        uint256 _bidFee,
        uint256 _timeoutPeriod
    )
        public
    {
        token = _token;
        bidIncrement = _bidIncrement;
        bidFee = _bidFee;
        timeoutPeriod = _timeoutPeriod;

        seller = msg.sender; 
        auctionEnd = now + timeoutPeriod;
        highBidder = seller;
    }

    event Bid(address highBidder, uint256 highBid);

    function withdraw() public {
        uint256 amount = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        msg.sender.transfer(amount);
    }

    function bid() public payable {
        require(now < auctionEnd);
        require(msg.sender != highBidder);

        balanceOf[msg.sender] += msg.value;

        require(balanceOf[msg.sender] >= highBid + bidIncrement + bidFee);

        balanceOf[seller] += bidIncrement + bidFee;
        balanceOf[highBidder] += highBid;
        balanceOf[msg.sender] -= highBid + bidIncrement + bidFee;

        highBid += bidIncrement;
        highBidder = msg.sender;
        auctionEnd = now + timeoutPeriod;
        emit Bid(highBidder, highBid);
    }

    function resolve() public { 
        require(now >= auctionEnd); 
        uint256 t = token.balanceOf(this);
        require(token.transfer(highBidder, t));
    }
}