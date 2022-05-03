// Solidity program to demonstrate how SmaC use'structs'
pragma solidity ^0.5.0;
  
// Creating a contract 
contract Library {
  
   // Declaring a personalized struct
   struct Book { 
      string name; 
      string writter; 
      string publisher;
      uint id;
      bool available;
   }
  
   // Declaring a structure object 
   Book book1;  
   
   // Assigning values to the fields 
   // for the structure object book2 
   Book book2 = Book("Building Ethereum DApps","Roberto Infante","Manning",2, false);
   
   Book[] bookOrganizer;
   
  
   // Defining a function to set values for the fields for structure book1
   function insert_book1_detail() public {
      book1 = Book("Introducing Ethereum and Solidity","Chris Dannen","Apress",1, true);
   } 
   
   // Defining function to print book2 details
   function book2_info()public view returns (string, string, string, uint, bool) {              
      return(book2.name, book2.writter, book2.publisher, book2.id, book2.available);  
   } 
     
   // Defining function to print some book1 details
   function  book1_info() public view returns (string, uint) {
      return (book1.name, book1.id);
   }
   
   function create_new_book(string _nameBook, string _writter, string _publisher, uint _id, bool _available) public {
   	  Book book = Book(_nameBook, _writter, _publisher, _id, _available);
   	  insert_books_organizer(book);
   }
    
   // Insert books in structure
   function insert_books_organizer(Book book) public {
	  bookOrganizer.push(book);    
   }    
  
   //Search books in structure using the Book's name and the Book's writter name
   function searchBook(string name, string writter) public returns(Book book){
		uint counter = 0;
		while(counter <= bookOrganizer.length && book[counter].name != name && book[counter].writter != writter){   		
			require(msg.balance >= 100 wei);//To avoid infinite loop 
	        if(book[counter].name == name && book[i].writter == writter){ 
	        	return book[counter];
	            break;
	        } 
	        else{    
	        	counter++;   
	        }
		} 
   }
   
    //Search books in structure using the Book's id
   function searchBook(uint id) public returns(Book book){
		uint counter = 0;
		while(counter <= bookOrganizer.length && book[counter].id != book.id){   		
			require(msg.balance >= 100 wei);//To avoid infinite loop 
	        if(book[counter].id == book.id){ 
	        	return book[counter];
	            break;
	        }
	        else{
	        	counter++;
	        }
		}
   }
     
   function searchInfoBook(string name, string writter) public returns(string, string, string, uint, bool){
   	  Book book = searchBook(name,writter);
   	  return(book.name, book.writter, book.publisher, book.id, book.available);  
   }
   
   function searchInfoBook(uint _id) public returns(string, string, string, uint, bool){
   	  Book book = searchBook(id);
   	  return(book.name, book.writter, book.publisher, book.id, book.available);  
   }
  

}