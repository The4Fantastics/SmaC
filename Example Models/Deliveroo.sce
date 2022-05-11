// Solidity program to demonstrate how SmaC use predefined 'structs'
pragma solidity >=0.3.24;
  
// Creating a contract   
contract Deliveroo {
   
   struct Product{
       string code;
       string name;
       uint256 price;
       uint256 amount;
   }
   
   // Declaring a User struct, this type is predefined in SmaC
   struct User { 
   	  address idAddress;
      string name;
      string surname;   
      string email;
      string city; 
      string street;
      uint256 cp;
   }  

    // Declaring a Company struct, this type is predefined in SmaC
   struct Company { 
   	  address idAddress;     
      string name;
      string city;
      string email; 
      string street; 
      uint256 cp;
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
   DeliveryUser public deliveryUser;
   uint256 private commissionDeliveryCompany;
   uint256 private commissionDeliveryUser;
   uint256 private priceOrder;
   Company private restaurant; 
   Company private deliveryCompany;
   DeliveryUser [] listDeliveryUsers;
   Product [] listProducts;
   mapping (address => DeliveryUser) registerDeliveryUsers;
   mapping (uint256 => bool) availableStreetDelivery;
   mapping (string => Product) availableProduct;
   

   constructor(string _nameDeliveryCompany, string _city, string _email, string _street, uint256 _cp, uint256 _commissionDeliveryCompany, uint256 _commissionDeliveryUser) public payable{
      deliveryCompany.idAddress = msg.sender;
      deliveryCompany.name = _nameDeliveryCompany;
      deliveryCompany.city = _city;
      deliveryCompany.email = _email;
      deliveryCompany.street = _street;
      deliveryCompany.cp = _cp;
      commissionDeliveryCompany = _commissionDeliveryCompany;
      commissionDeliveryUser = _commissionDeliveryUser;
   }

   modifier onlyDeliveryCompany(){
   	 require(msg.sender == deliveryCompany.idAddress);  
   	 _;
   }
   
   modifier onlyUser(){
   	 require(msg.sender != deliveryCompany.idAddress); 
     require(msg.sender != restaurant.idAddress);
     require(msg.sender != deliveryUser.idAddress);      
   	 _;
   }
   
   modifier onlyRestaurantCompany(){
   	 require(msg.sender == restaurant.idAddress);  
   	 _;
   }
   
   modifier onlyDeliveryUser(){
   	 require(msg.sender == deliveryUser.idAddress);  
   	 _;
   }
   
   
   event ApproveOrder(string message);
   event DeniedOrder(string message);
   event UserPayAccepted(string message);
   
   // Defining a function to set values for the fields for predefined type structure User
   function set_User_detail(address  _address,string _nameUser, string _surnameUser,string _email,string _city, string _street,uint256 _cp) public {
      require(_address != address(0));//To avoid that they pass us an empty account and it is a valid account
      user = User(_address,_nameUser,_surnameUser,_email,_city,_street,_cp);  
   } 
     
    // Defining a function to set values for the fields for personalized type structure UserDelivery
   function set_UserDelivery_detail(address _address,string _nameUser, string _surnameUser,string _email,bool _available) public {
      require(_address != address(0));//To avoid that they pass us an empty account and it is a valid account
      DeliveryUser memory deliveryNewUser = DeliveryUser(_address,_nameUser,_surnameUser,_email,_available); 
      listDeliveryUsers.push(deliveryNewUser);  
      registerDeliveryUsers[deliveryNewUser.idAddress] = deliveryNewUser;
   }  
    
    // Defining function to print user details
   function get_User_Details() public view returns (address , string, string, string,string) {
      return (user.idAddress,user.name,user.surname,user.email,user.street);
   }  
   
   // Defining a function to set values for the fields for personalized type structure Company
   function set_Restaurant_detail(address  _address,string _name, string _city,string _email,string _street,uint256 _cp) public {
      require(_address != address(0));//To avoid that they pass us an empty account and it is a valid account
      restaurant = Company(_address,_name,_city,_email,_street,_cp); 
   }
     
   // Defining function to print restaurant company details 
   function get_Restaurant_Details() public view returns (address , string, string, string, string, uint256) {
      return (restaurant.idAddress,restaurant.name,restaurant.city, restaurant.email,restaurant.street, restaurant.cp); 
   }

   // Defining a function to set values for the fields for personalized type structure UserDelivery
   function set_ProductRestaurant_detail(string _code,string _name, uint _amount, uint _price) public onlyRestaurantCompany payable {
      require(_amount >= 0, "Amount must be greater than 0");
      Product memory product = Product(_code,_name,_amount,_price); 
      if(_amount > 0){
           availableProduct[_code] = product;
      }    
   }  

   //Function to change the quantity of an available product that the restaurant has at this moment
   function change_Amount_Product_Restaurant(string _code,uint _amount) public onlyRestaurantCompany{
      Product memory product  =  availableProduct[_code];
      if(_amount == 0){
         delete availableProduct[_code];
      }
      else{
         product.amount = _amount;
      }
   }
 
  //Function to change the quantity of an available product that the restaurant has at this moment if the user finally the order
  function change_Amount_Product_User(string _code,uint _amount) private{
      Product memory product  =  availableProduct[_code];
      product.amount = product.amount - _amount;
      if(product.amount == 0){
          delete availableProduct[_code];
      }
   }
          
   // Defining function to print Company details
   function get_Company_info() public view returns (address , string, string, string, string) {              
       return(deliveryCompany.idAddress,deliveryCompany.name,deliveryCompany.city,deliveryCompany.email,deliveryCompany.street);  
   } 
 
   
   // Defining function to establish price to Order
   function set_Price_Order(uint256 _price, uint256 _amount) private {
      require(_price > 0, "Price must be greater than 0");//To avoid that they pass us a invalid price
      priceOrder += _price * _amount;
   } 

    // Defining function to establish price to Order
   function get_Price_Order() public returns (uint256) {      
      return priceOrder;
   } 

    // Defining a function to set available stret
   function set_available_street(uint256 _cp, bool _available) public onlyDeliveryCompany{
       availableStreetDelivery[_cp] = _available;
   }
   
     // Defining a function to check if a street is available or not
   function is_available_street(uint256 _cp) public returns (bool){
      return  availableStreetDelivery[_cp];
   } 

   // Defining function to modify the Delivery Company's commision
   function set_Modify_Delivery_Commision(uint256 _commission) private onlyDeliveryCompany{
      require(_commission > 0, "Price must be greater than 0");//To avoid that they pass us a invalid price
      commissionDeliveryCompany = _commission;
   } 

   // Defining function to modify the Delivery User's commision
   function set_Modify_DeliveryUser_Commision(uint256 _commission) private onlyDeliveryCompany{
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
   	   return (deliveryUser.idAddress, deliveryUser.name, deliveryUser.surname, deliveryUser.email, deliveryUser.available);
   }   
   
   //Function to select available products
   function select_restaurant_product(string _code, uint _amount) public onlyUser{
       Product memory productOrder  =  availableProduct[_code];
       require(_amount > 0, "You must choose min 1 unit");
       require(productOrder.amount >= _amount, "There is not enough quantity available to satisfy the order");
       set_Price_Order(productOrder.price, _amount);
       listProducts.push(productOrder);
   }
   
   //Search for an available delivery man to be able to assign the order
   function assignDeliveryUser() private onlyDeliveryCompany returns (bool){ 
   	    bool assigned = false; 
   		for(uint i = 0; i <= listDeliveryUsers.length; i++){   		
   			require(deliveryCompany.idAddress.balance >= 100 szabo);//To avoid infinite loop 
	        if(listDeliveryUsers[i].available == true && assigned == false){ 
	        	deliveryUser = listDeliveryUsers[i];//Assign avaible delivery user
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
        deleteStockRestaurant();   
   	    get_DeliveryUser_Details(deliveryUser.idAddress);
   }

   // Subtract available products  
   function deleteStockRestaurant() private{
       for(uint i = 0;i <= listProducts.length; i++){
       		require(msg.sender.balance > 1000 wei);
       		string _code = listProducts[i].code;
       		uint256 _amount = listProducts[i].amount;
            change_Amount_Product_User(_code,_amount);
       }
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
   
   function restaurantReceiveMoney() public onlyDeliveryCompany payable{ 
      if(confirmOrderRestaurant && confirmReceiveOrderDeliveryUser){ 
      	 confirmOrderRestaurant = false;
      	 uint totalCommission = commissionDeliveryCompany+commissionDeliveryUser;
      	 uint restaurantAmount = this.balance-totalCommission; 
   	     restaurant.idAddress.transfer(restaurantAmount);  	      
      } 
   }

   function deliveryUserReceiveMoney() public onlyDeliveryCompany payable{
      if(confirmOrderUser && confirmOrderDeliveryUser){
      	 uint comission =  commissionDeliveryUser;
      	 commissionDeliveryUser = 0;
   	     deliveryUser.idAddress.transfer(commissionDeliveryUser);
         deliveryUser.available = true;         
      }
   }
   
   function deliveryCompanyReceiveMoney() public onlyDeliveryCompany payable{
      if(confirmOrderUser && confirmOrderDeliveryUser){
      	 uint comission = commissionDeliveryCompany;
      	 commissionDeliveryCompany = 0;
   	     deliveryCompany.idAddress.transfer(comission);
         confirmOrderUser = false;             
         confirmReceiveOrderDeliveryUser = false;
         priceOrder = 0;
      }
   }

}