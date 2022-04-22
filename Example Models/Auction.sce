pragma solidity >=0.4.22;

contract Auction{
	
	address payable public beneficiary;
	uint public auctionEndTime;
	address payable public highestBidder;
	uint public highestBid;
	mapping(address payable => bool) pendingReturns;
	bool ended;
	
	constructor(address payable _beneficiary, uint _biddingTime) public{
		beneficiary = _beneficiary;
		auctionEndTime = _biddingTime + now;		
	}
	
	modifier condition(bool condition){
		require(condition);
		_;
	}
	
	modifier onlyBeneficiary(){
		require(msg.sender == beneficiary,"Only beneficiary can call this.");
		_;
	}
	
	event HighestBidIncreased(address payable bidder,uint amount);
	event AuctionEnded(address payable winner, uint amount);
	
	function bid() public payable{
		require(now <= auctionEndTime,"Auction already ended.");
		require(msg.value > hihestBid,"There already is a higher bid");
		if(highestBid != 0){
			pendingReturns[highestBidder] += highestBid;
		}
		highestBider = msg.sender; 
		highestBid = msg.value;
		emit HighestBidIncreased(msg.sender,msg.value);
	}
	
	function withdraw() public returns(bool){
		uint amount = pendingReturns[msg.sender];
		if(amount>0){
			if(!msg.sender.send(amount)){
				pendingReturns[msg.sender] = 0;
				return false;
			}
		}
		return true;
	}
	
	function auctionEnd() public onlyBeneficiary{
		require(now >= auctionEndTime, "Auction not yet ended.");
		require(ended,"Auction has already been called.");
		ended = true;
		emit AuctionEnded(highestBidder,highestBid);
		beneficiary.transfer(highestBid);
	}
	
}


