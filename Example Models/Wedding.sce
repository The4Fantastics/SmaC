
pragma solidity >=0.8.0;

contract MarriageContract {
 	 	
 	struct User{		
		address  idAddress;
		string nameUser;
		string surnameUser; 
		string email; 
		bool accept;
	}		
 	
 	User gubernamental_account;
 	mapping (address => User) registerUsersMarriage;
    mapping (address => User) registerWitnessUsersMarriage; 
    uint private counterRegisterUsersMarriage = 0;
    uint private counterWitnessUsersMarriage = 0;
 	uint256 private tax;
    address  private address1MarriageUser;
    address  private address2MarriageUser;
    address  private address1WitnessUser;
    address  private address2WitnessUser;
 	
 	constructor(uint256 _tax) public { 		
 		gubernamental_account.idAddress = msg.sender;
        tax = _tax;
 	}
 	
 	modifier onlyGubernamentalAccount(){
 		require(msg.sender == gubernamental_account.idAddress, "Only gubernamental user can call this.");
 		_;
 	}

    modifier onlyMarriageAccount(){
 		require(msg.sender == registerUsersMarriage[msg.sender].idAddress, "Only marriage user can call this.");
 		_;
 	}

    modifier onlyWitnessAccount(){
 		require(msg.sender == registerWitnessUsersMarriage[msg.sender].idAddress, "Only witness user can call this.");
 		_;
 	}

    modifier controlUsersMarriage(){
        require(counterRegisterUsersMarriage < 2, "Only two people can get married.");
 		_;
    }

    modifier controlWitnessUsersMarriage(){
        require(counterWitnessUsersMarriage < 2, "Only two witnesses can validate the marriage.");
 		_;
    }

    event RegisterSystem(string message);
    event SendConfirmation(string message);
    event SendRejection(string message);
    event AcceptProcess(string message);


    function setModifyTaxMarriage(uint256 _tax) private onlyGubernamentalAccount{
        tax = _tax;
    } 
 	
 	function insertDataUser(address _address,string memory _nameUser, string memory _surnameUser,string memory _email) public onlyGubernamentalAccount controlUsersMarriage {
		require(_address != address(0),"Account no valid");//To avoid that they pass us an empty account and it is a valid account
	    User memory user = User(_address,_nameUser,_surnameUser,_email,false); 
	    registerUsersMarriage[user.idAddress] = user;	
        assignAddressMarriageUsers(user.idAddress); 
        counterRegisterUsersMarriage++;
        emit RegisterSystem ("The user has been registered in the system");
 	}
 	
 	function insertDataUser(string memory _nameUser, string memory _surnameUser,string memory _email) public  controlUsersMarriage{
		require(msg.sender != address(0),"Account no valid");//To avoid that they pass us an empty account and it is a valid account
	    User memory user = User(msg.sender,_nameUser,_surnameUser,_email,false); 
	    registerUsersMarriage[user.idAddress] = user;
        assignAddressMarriageUsers(user.idAddress);
        counterRegisterUsersMarriage++;
        emit RegisterSystem ("The user has been registered in the system");
 	}

    function assignAddressMarriageUsers(address _address) private{
        if(counterRegisterUsersMarriage < 1){
            address1MarriageUser = _address;
        }
        else{
            address2MarriageUser = _address;
        }
    }

    function insertDataWitnessUser(address _address,string memory _nameUser, string memory _surnameUser,string memory _email) public onlyGubernamentalAccount controlUsersMarriage{
		require(_address != address(0),"Account no valid");//To avoid that they pass us an empty account and it is a valid account
	    User memory user = User(_address,_nameUser,_surnameUser,_email,false); 
	    registerWitnessUsersMarriage[user.idAddress] = user;	
        assignAddressWitnessUsers(user.idAddress);	
        counterWitnessUsersMarriage++;
        emit RegisterSystem ("The user has been registered in the system");
 	}
 	
 	function insertDataWitnessUser(string  memory _nameUser, string memory _surnameUser,string memory _email) public{
		require(msg.sender != address(0),"Account no valid");//To avoid that they pass us an empty account and it is a valid account
	    User memory user = User(msg.sender,_nameUser,_surnameUser,_email,false); 
	    registerWitnessUsersMarriage[user.idAddress] = user;		
        assignAddressWitnessUsers(user.idAddress);	
        counterWitnessUsersMarriage++;
        emit RegisterSystem ("The user has been registered in the system");
 	} 

     function assignAddressWitnessUsers(address _address) private{
        if(counterWitnessUsersMarriage < 1){
            address1WitnessUser = _address;
        }
        else{
            address2WitnessUser = _address;
        }
    }
 	
 	function acceptProcess(bool accept) public onlyMarriageAccount payable{
        require(msg.sender != address(0), "Account no valid");//To avoid that they pass us an empty account and it is a valid account
        require(msg.sender.balance >= tax, "Account can't paid the marriage tax");//To avoid that they pass us an empty account and it is a valid account
 		User memory user = registerUsersMarriage[msg.sender];
        if(user.accept == false && accept == true){      
            user.accept = true;
            payable(user.idAddress).transfer(tax); 
            emit SendConfirmation ("Accept");
        }
 	}
 
    function changeOpinionProcessMarriageUser(bool opinion) public onlyMarriageAccount payable{
        require(msg.sender != address(0), "Account no valid");//To avoid that they pass us an empty account and it is a valid account
        require(msg.sender.balance >= tax, "Account can't paid the marriage tax");//To avoid that they pass us an empty account and it is a valid account
 		User storage user = registerUsersMarriage[msg.sender];
 		require(user.accept != opinion,"User doesn't change the original opinion");
        if(user.accept == false && opinion == true){
            user.accept = true;
            payable(user.idAddress).transfer(tax); 
            emit SendConfirmation ("User accepts the process");
        }
        if(user.accept == true && opinion == false){
        	user.accept = false;
            payable(user.idAddress).transfer(tax); 
            emit SendRejection ("User rejects the process");
        } 
 	}
 

    function acceptProcessWitnessUsers(bool opinion) public onlyWitnessAccount payable{
        require(msg.sender != address(0), "Account no valid");//To avoid that they pass us an empty account and it is a valid account
        require(msg.sender.balance >= tax/4, "Account can't paid the marriage tax");
 		User storage user = registerWitnessUsersMarriage[msg.sender];
        if(user.accept == false && opinion == true){
            user.accept = true;
            payable(user.idAddress).transfer(tax/4);
            emit SendConfirmation ("Witness accepts the process");
        }
        
 	}

    function changeOpinionProcessWitnessUser(bool opinion) public onlyWitnessAccount payable{
        require(msg.sender != address(0), "Account no valid");//To avoid that they pass us an empty account and it is a valid account
        require(msg.sender.balance >= tax, "Account can't paid the marriage tax");//To avoid that they pass us an empty account and it is a valid account
 		User storage user = registerWitnessUsersMarriage[msg.sender];
 		require(user.accept != opinion,"Witness doesn't change the original opinion");
        if(user.accept == false && opinion == true){
            user.accept = true;
            payable(user.idAddress).transfer(tax/4); 
            emit SendConfirmation ("Witness accepts the process");
        }
        if(user.accept == true && opinion == false){
            user.accept = false;
            payable(user.idAddress).transfer(tax/4);
            emit SendRejection ("Witness rejects the process");
        }
 	}
 	
 	function confirmGubernamentalMarriageProccess() public onlyGubernamentalAccount payable{
        require(registerUsersMarriage[address1MarriageUser].accept == true,"The spouse has not accepted the marriage agreement");
        require(registerUsersMarriage[address2MarriageUser].accept == true,"The spouse has not accepted the marriage agreement");
        require(registerWitnessUsersMarriage[address1WitnessUser].accept == true,"The witness has not accepted the marriage agreement");
        require(registerWitnessUsersMarriage[address2WitnessUser].accept == true,"The witness has not accepted the marriage agreement");
        uint amount = address(this).balance;
        uint witnessTax = tax/4 * 2;
        payable(msg.sender).transfer(amount - witnessTax);
        emit AcceptProcess("The marriage agreement has been accepted by all parties");
        cleanUsersMarriageProccess();
 	}
 	
 	function cleanUsersMarriageProccess() public onlyGubernamentalAccount payable{
        delete registerUsersMarriage[address1MarriageUser];        
        delete registerUsersMarriage[address2MarriageUser];
        uint amount = address(this).balance;
        uint witnessTax = tax/4;
        User memory witnessUser1 = registerWitnessUsersMarriage[address1WitnessUser];
        User memory witnessUser2 = registerWitnessUsersMarriage[address2WitnessUser];
        payable(witnessUser1.idAddress).transfer(witnessTax);
        payable(witnessUser2.idAddress).transfer(witnessTax);
        delete registerWitnessUsersMarriage[address1WitnessUser];
        delete registerWitnessUsersMarriage[address2WitnessUser];
        counterRegisterUsersMarriage = 0;
        counterWitnessUsersMarriage = 0;
        address1MarriageUser = address(0);
        address2MarriageUser = address(0);
        address1WitnessUser = address(0);
        address2WitnessUser = address(0);
 	}
 		 	
}  
