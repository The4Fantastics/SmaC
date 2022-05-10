pragma solidity ^0.4.24;

import "../common/ierc20token.sol";

contract DollarAuction {
    address  public seller;

    IERC20Token public token;
    uint256 public minIncrement;
    uint256 public timeoutPeriod;

    uint256 public auctionEnd;

    address  public highBidder;
    uint256 public highBid;

    address  public secondBidder;
    uint256 public secondBid;
    mapping(address => uint256) public balanceOf;
   
   constructor(
        IERC20Token _token,
        uint256 _minIncrement,
        uint256 _timeoutPeriod
    )
        public
    {
        token = _token;
        minIncrement = _minIncrement;
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

   

    function bid(uint256 amount) public payable {
        require(now < auctionEnd);
        require(amount >= highBid+minIncrement);
        require(msg.sender != highBidder);

        balanceOf[msg.sender] += msg.value; 

        uint256 increase = amount - secondBid;
        balanceOf[seller] += increase;
        balanceOf[secondBidder] += secondBid;
        require(balanceOf[msg.sender] >= amount);
        balanceOf[msg.sender] -= amount;
        secondBid = highBid;
        secondBidder = highBidder;

        highBidder = msg.sender;
        highBid = amount;
        auctionEnd = now + timeoutPeriod;
        emit Bid(highBidder, amount);
    }

    function resolve() public {
        require(now >= auctionEnd);

        uint256 t = token.balanceOf(this);
        require(token.transfer(highBidder, t));
    }
}