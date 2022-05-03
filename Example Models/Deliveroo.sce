// Solidity program to demonstrate how SmaC use predefined 'structs'
pragma solidity >=0.3.24;
  
// Creating a contract
contract Deliveroo {
  
   // Declaring a Company struct, this type is predefined in SmaC
   struct Company { 
   	  address idAddress;     
      string name;
      string city;
      string email;
      string street;
   }
   
   // Declaring a User struct, this type is predefined in SmaC
   struct User { 
   	  address idAddress;
      string name;
      string surname;   
      string email;
      string city; 
      string street;
   }  
  
  // Declaring a Delivery struct, this type is not predefined in SmaC
   struct DeliveryUser{
   	  address idAddress; 
      string name;
      string surname;
      string email;  
      bool available;
   }
  
   // Declaring a structure object 
   User private user; 
   bool private confirmOrderRestaurant = false;
   bool private confirmReceiveOrderDeliveryUser = false;
   bool private confirmOrderUser = false;
   bool private confirmOrderDeliveryUser = false;
   DeliveryUser private assignedDeliveryUser;
   DeliveryUser public deliveryUser;
   uint private commissionDeliveryCompany;
   uint private commissionDeliveryUser;
   uint private priceOrder;
   Company private restaurant; 
   Company private deliveryCompany;
   DeliveryUser [] listDeliveryUsers;
   mapping (address => DeliveryUser) registerDeliveryUsers;
  
   
   constructor(string _nameDeliveryCompany, string _city, string _email, string _street, uint _commissionDeliveryCompany, uint _commissionDeliveryUser) public{
      deliveryCompany.idAddress = msg.sender;
      deliveryCompany.name = _nameDeliveryCompany;
      deliveryCompany.city = _city;
      deliveryCompany.email = _email;
      deliveryCompany.street = _street;
      commissionDeliveryCompany = _commissionDeliveryCompany;
      commissionDeliveryUser = _commissionDeliveryUser;
   }

   modifier onlyDeliveryCompany(){
   	 require(msg.sender == deliveryCompany.idAddress);  
   	 _;
   }
   
   modifier onlyUser(){
   	 require(msg.sender == user.idAddress);  
   	 _;
   }
   
   modifier onlyRestaurantCompany(){
   	 require(msg.sender == restaurant.idAddress);  
   	 _;
   }
   
   modifier onlyDeliveryUser(){
   	 require(msg.sender == assignedDeliveryUser.idAddress);  
   	 _;
   }
   
   
   event ApproveOrder(string message);
   event DeniedOrder(string message);
   event UserPayAccepted(string message);
   
   // Defining a function to set values for the fields for predefined type structure User
   function set_User_detail(address  _address,string _nameUser, string _surnameUser,string _email,string _city, string _street) public onlyUser {
      require(_address != address(0));//To avoid that they pass us an empty account and it is a valid account
      user = User(_address,_nameUser,_surnameUser,_email,_city,_street);  
   } 
     
    // Defining a function to set values for the fields for personalized type structure UserDelivery
   function set_UserDelivery_detail(address _address,string _nameUser, string _surnameUser,string _email,bool _available) public {
      require(_address != address(0));//To avoid that they pass us an empty account and it is a valid account
      deliveryUser = DeliveryUser(_address,_nameUser,_surnameUser,_email,_available); 
      listDeliveryUsers.push(deliveryUser);  
      registerDeliveryUsers[deliveryUser.idAddress] = deliveryUser;
   }  
    
    // Defining function to print user details
   function get_User_Details() public view returns (address , string, string, string,string) {
      return (user.idAddress,user.name,user.surname,user.email,user.street);
   }  
   
   // Defining a function to set values for the fields for personalized type structure Company
   function set_Restaurant_detail(address  _address,string _name, string _city,string _email,string _street) public {
      require(_address != address(0));//To avoid that they pass us an empty account and it is a valid account
      restaurant = Company(_address,_name,_city,_email,_street); 
   }
     
   // Defining function to print restaurant company details 
   function get_Restaurant_Details() public view returns (address , string, string, string, string) {
      return (restaurant.idAddress,restaurant.name,restaurant.city, restaurant.email,restaurant.street); 
   }
      
   // Defining function to print Company details
   function get_Company_info() public view returns (address , string, string, string, string) {              
       return(deliveryCompany.idAddress,deliveryCompany.name,deliveryCompany.city,deliveryCompany.email,deliveryCompany.street);  
   } 
   
   // Defining function to establish price to Order
   function set_Price(uint _price) private onlyRestaurantCompany{
      require(_price > 0, "Price must be greater than 0");//To avoid that they pass us a invalid price
      priceOrder = _price;
   } 

   // Defining function to modify the Delivery Company's commision
   function set_Modify_Delivery_Commision(uint _commission) private onlyDeliveryCompany{
      require(_commission > 0, "Price must be greater than 0");//To avoid that they pass us a invalid price
      commissionDeliveryCompany = _commission;
   } 

   // Defining function to modify the Delivery User's commision
   function set_Modify_DeliveryUser_Commision(uint _commission) private onlyDeliveryCompany{
      require(_commission > 0, "Price must be greater than 0");//To avoid that they pass us a invalid price
      commissionDeliveryUser = _commission; 
   } 
    
    // Defining function to print Delivery User details 
   function get_DeliveryUser_Details(address  idAddressUserDelivery) public returns (address , string, string, string, bool) {
      require(idAddressUserDelivery != address(0));//To avoid that they pass us an empty account and it is a valid account
      deliveryUser = registerDeliveryUsers[idAddressUserDelivery];
      return (deliveryUser.idAddress,deliveryUser.name,deliveryUser.surname,deliveryUser.email,deliveryUser.available);
   } 
   
    // Defining function to print delivery user assigned details for the order  
   function getInfoAssignedDeliveryUser() public view returns(address , string, string, string, bool){
   	   return (assignedDeliveryUser.idAddress, assignedDeliveryUser.name, assignedDeliveryUser.surname, assignedDeliveryUser.email, assignedDeliveryUser.available);
   }   
   
     //Search for an available delivery man to be able to assign the order
   function assignDeliveryUser() private onlyDeliveryCompany returns (bool){ 
   	    bool assigned = false; 
   		for(uint i = 0; i <= listDeliveryUsers.length; i++){   		
   			require(deliveryCompany.idAddress.balance >= 100 szabo);//To avoid infinite loop 
	        if(listDeliveryUsers.available == true && assigned == false){ 
	        	assignedDeliveryUser = listDeliveryUsers[i];//Assign avaible delivery user
	        	assigned = true;
                break;
	        }
    	} 
    	return assigned;
   }   
   
   // The user confirms that he wishes to place the order and sends the requested amount of expense of the order   
   function sendConfirmationOrder() public onlyUser payable{  	
   	    require(user.idAddress.balance >= priceOrder, "User does not have sufficient funds"); 
   	    require(assignDeliveryUser(), "Delivery User can not be assigned");
   	    user.idAddress.transfer(priceOrder);  
   	    get_DeliveryUser_Details(assignedDeliveryUser.idAddress);
   }     
    
      
   function approveOrderByRestaurantCompany(string message) public onlyRestaurantCompany{
   	  emit ApproveOrder(message);
   }
   
   function deniedOrderByRestaurantCompany(string message) public onlyRestaurantCompany{
   	  emit DeniedOrder(message);
   }
   
   function approveOrderByDeliveryCompany(string message) public onlyDeliveryCompany{
   	  emit ApproveOrder(message); 
   }
   
   
   function receivedOrder() public onlyUser{
       confirmOrderUser = true;
   }
      
   function deliveredOrder() public onlyDeliveryUser{
       confirmOrderDeliveryUser = true;
   } 
   
   function restaurantReceiveMoney() public onlyDeliveryCompany{ 
      if(confirmOrderRestaurant && confirmReceiveOrderDeliveryUser){ 
      	 confirmOrderRestaurant = false;
      	 uint totalCommission = commissionDeliveryCompany+commissionDeliveryUser;
      	 uint restaurantAmount = this.balance-totalCommission; 
   	     restaurant.idAddress.transfer(restaurantAmount);  	      
      } 
   }

   function deliveryUserReceiveMoney() public onlyDeliveryCompany{
      if(confirmOrderUser && confirmOrderDeliveryUser){
      	 confirmOrderDeliveryUser = false;   
   	     assignedDeliveryUser.idAddress.transfer(commissionDeliveryUser);
         assignedDeliveryUser.available = true;         
      }
   }
   
   function deliveryCompanyReceiveMoney() public onlyDeliveryCompany{
      if(confirmOrderUser && confirmOrderDeliveryUser){
   	     deliveryCompany.idAddress.transfer(commissionDeliveryCompany);
         confirmOrderUser = false;             
         confirmReceiveOrderDeliveryUser = false;
         priceOrder = 0;
      }
   }

}