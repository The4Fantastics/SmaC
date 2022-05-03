pragma solidity >=0.4.22 <0.6.0;

contract Purchase{
	 
	uint public val;  
	address payable public sender;   
	address payable public buyer;    
	enum State {Created,Locked,Inactive} 
	State public state;   
	
	constructor() public payable{   	
		require((2 * val) == msg.value,"Value has to be even."); 
		seller = msg.sender;  
		val = msg.value/2;
	}
	 
	modifier condition(bool _condition){
		require(_condition);
		_;
	}  
	
	modifier onlyBuyer(){
		require(msg.sender == buyer,"Only buyer can call this.");
		_;
	}
	 
	modifier onlySeller(){
		require(msg.sender == seller,"Only seller can call this.");
		_;
	}
	    
	modifier inState(State _state){
		require(state == _state,"Invalid state.");   
		_; 
	}
	                  
	event Aborted();
	event PurchaseConfirmed();   
	event ItemReceived();    
	  
	function abort() public 
	onlySeller inState(State.Created) view{      
		emit Aborted();      
		state = State.Inactive;      
		seller.transfer(address(this).balance);	   
		selfdestruct(msg.sender);                 
	}    
	     
	function confirmPurchase() public    
	inState(State.Created) condition(msg.value) payable{
		emit PurchaseConfirmed();  
		buyer = msg.value;         
		state = State.Locked; 
	}
	 
	function confirmReceived() public 
	onlyBuyer inState(State.Locked){
		emit ItemReceived();
		state = State.Inactive; 
		buyer.transfer(val); 
		seller.transfer(address(this).balance); 
	}
}




