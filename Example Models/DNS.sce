pragma solidity ^0.4.18;	

contract DNS {
	
	mapping(bytes32=>bytes16) domain; 
	mapping(bytes32=>address payable) owner;

	
	function is_available(bytes32 domain_name) private view returns (bool){
		if(domain[domain_name] == 0){
			return  true;
		}
		else{ 
			return false;
		}
		
	} 
	
			
	function register(bytes32 domain_name, bytes16 ip) public payable {
		require(is_available(domain_name));  
		owner[domain_name] = msg.sender;
		domain[domain_name] = ip;
	}
	
		
	function set_ip(bytes32 domain_name, bytes16 ip) public {
		if (msg.sender != owner[domain_name]){
			return;
		}  
		domain[domain_name] = ip;
	}
	


	function query_domain(bytes32 domain_name) public view returns (bytes16) {
		return domain[domain_name];
	}
	
	
	
	
}