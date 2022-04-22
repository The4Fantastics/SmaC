pragma solidity >0.4.0;

contract StorageNumber{
	
	uint number;
	address payable owner;
	
	constructor () public{
		owner = msg.sender;
	}
	
	modifier onlyOwner(){
		require(owner == msg.sender);
		_;
	}
	
	event NumberModified(string message); 
	
	function setNumber(uint _number) public onlyOwner{
		number = _number; 
	}
	
	function getNumber() public onlyOwner returns(uint){
		return number;
	}
		 
}