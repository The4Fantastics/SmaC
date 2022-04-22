pragma solidity >0.4.0;

contract StorageNumber{
	
	uint number;
	
	function setNumber(uint _number) public{
		number = _number;
	}
	
	function getNumber() public returns(uint){
		return number;
	}
		
}