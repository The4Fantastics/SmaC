pragma solidity >0.4.18;


contract Marriage {
 	 	
 	struct User{		
		address  idAddress;
		string nameUser;
		string surnameUser; 
		string email; 
		bool accept;
	}		
 	
 	User[2] usersMarriage;
 	User[2] witnessUsersMarriage;
 	User gubernamental_account;
 	mapping (address => User) registerUsers;
 	uint256 private tax;
 	
 	constructor(uint256 _tax) public { 		
 		gubernamental_account.idAddress = msg.sender;
        tax = _tax;
 	}
 	
 	modifier onlyGubernamentalAccount(){
 		require(msg.sender == gubernamental_account.idAddress, "Only gubernamental user can call this.");
 		_;
 	}

    event RegisterSystem(string message);
    event SendConfirmation(string message);
    event SendRejection(string message);


    function setModifyTaxMarriage(uint256 _tax) private onlyGubernamentalAccount{
        tax = _tax;
    } 
 	
 	function insertDataUser(address _address,string _nameUser, string _surnameUser,string _email) public{
 		require(usersMarriage.length < 2, "Cannot exceed the number of users");//To control the number of users
		require(_address != address(0),"Account no valid");//To avoid that they pass us an empty account and it is a valid account
        require(registerUsers[_address].idAddress ==  0, "Account available");
	    User memory user = User(_address,_nameUser,_surnameUser,_email,false); 
	    usersMarriage.push(user);  
	    registerUsers[user.idAddress] = user;	 
        emit RegisterSystem ("The user has been registered in the system");
 	}
 	
 	function insertDataUser(string _nameUser, string _surnameUser,string _email) public{
 		require(usersMarriage.length < 2, "Cannot exceed the number of users");//To control the number of users
		require(msg.sender != address(0),"Account no valid");//To avoid that they pass us an empty account and it is a valid account
        require(registerUsers[msg.sender].idAddress ==  0, "Account available");
	    User memory user = User(msg.sender,_nameUser,_surnameUser,_email,false); 
	    usersMarriage.push(user);  
	    registerUsers[user.idAddress] = user;	
        emit RegisterSystem ("The user has been registered in the system");
 	}

    function insertDataWitnessUser(address _address,string _nameUser, string _surnameUser,string _email) public{
 		require(witnessUsersMarriage.length < 2,"Cannot exceed the number of users");//To control the number of users
		require(_address != address(0),"Account no valid");//To avoid that they pass us an empty account and it is a valid account
        require(registerUsers[_address].idAddress ==  0, "Account available");
	    User memory user = User(_address,_nameUser,_surnameUser,_email,false); 
	    witnessUsersMarriage.push(user);  
	    registerUsers[user.idAddress] = user;		
        emit RegisterSystem ("The user has been registered in the system");
 	}
 	
 	function insertDataWitnessUser(string _nameUser, string _surnameUser,string _email) public{
 		require(witnessUsersMarriage.length < 2,"Cannot exceed the number of users");//To control the number of users
		require(msg.sender != address(0),"Account no valid");//To avoid that they pass us an empty account and it is a valid account
        require(registerUsers[msg.sender].idAddress ==  0, "Account available");
	    User memory user = User(msg.sender,_nameUser,_surnameUser,_email,false); 
	    witnessUsersMarriage.push(user);  
	    registerUsers[user.idAddress] = user;		
        emit RegisterSystem ("The user has been registered in the system");
 	} 
 	
 	function acceptProcess(bool accept, address  _address) public payable{
        require(_address != address(0), "Account no valid");//To avoid that they pass us an empty account and it is a valid account
        require(msg.sender.balance >= tax, "Account can't paid the marriage tax");//To avoid that they pass us an empty account and it is a valid account
        require(registerUsers[_address].idAddress !=  0, "Don't find account in the system");
 		User storage user = registerUsers[user.idAddress];
        if(user.accept == false && accept == true){      
            user.accept = true;
            msg.sender.transfer(tax); 
            emit SendConfirmation ("Accept");
        }
 	}
 
     function changeOpinionProcess(bool accept, address  _address) public payable{
        require(_address != address(0), "Account no valid");//To avoid that they pass us an empty account and it is a valid account
        require(msg.sender.balance >= tax, "Account can't paid the marriage tax");//To avoid that they pass us an empty account and it is a valid account
        require(registerUsers[_address].idAddress !=  0, "Don't find account in the system");
 		User storage user = registerUsers[user.idAddress];
 		require(user.accept != accept,"User doesn't change the original opinion");
        if(user.accept == false && accept == true){
            user.accept = true;
            msg.sender.transfer(tax);
            emit SendConfirmation ("User change opinion");
        }
        if(user.accept == true && accept == false){
        	user.accept = false;
            msg.sender.transfer(tax);
            emit SendConfirmation ("User change opinion");
        } 
 	}

    function acceptProcessWitnessUsers(bool accept, address  _address) public payable{
        require(_address != address(0), "Account no valid");//To avoid that they pass us an empty account and it is a valid account
        require(msg.sender.balance >= tax/4, "Account can't paid the marriage tax");
        require(registerUsers[_address].idAddress !=  0, "Don't find account in the system");
 		User storage user = witnessUsersMarriage[user.idAddress];
        if(user.accept == false && accept == true){
            user.accept = true;
            msg.sender.transfer(tax/4);
            emit SendConfirmation ("Accept");
        }
 	}
 	
 	function confirmGubernamentalMarriageProccess() public onlyGubernamentalAccount payable{
 		require(usersMarriage.length == 2, "A spouse is missing to finalize the marriage process");
        require(witnessUsersMarriage.length == 2, "A witness is missing to finalize the marriage process");
        bool _state = false;
        bool _stateWitness = false;
        for(uint i = 0; j < usersMarriage.length;i++){
        	 require(msg.sender.balance > 1 ether);
             if(usersMarriage[i].accept != false){
                 _state = true;
             }
             else{
                 break;
             }
        }
        if(_state != false){
            for(uint j = 0; j < witnessUsersMarriage.length;j++){ 
            	require(msg.sender.balance > 1 ether);
                if(witnessUsersMarriage[i].accept != false){
                    _stateWitness = true;
                }
                else{
                    break;
                }
            }
            if(_state == true && _stateWitness == true){
                gubernamental_account.idAddress.transfer(address(this).balance);
                emit SendConfirmation ("Valid marriage agreement");
            }
            else{
                emit SendRejection("Reject agreement");
            }
        }
        else{
            emit SendRejection("Reject agreement");
        }
 	}
 	
 	function cleanUsersMarriageProccess() public onlyGubernamentalAccount payable{
 		delete usersMarriage;
 		delete witnessUsersMarriage;
 	}
 		 	
         
	
}  