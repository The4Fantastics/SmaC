pragma solidity >0.7.0;


contract Calculator{
	   
	function sum(uint256 num1, uint256 num2) public returns(uint256){
		uint256 result = num1 + num2;
		return result;
	} 
	 
	function subtract(uint256 num1, uint256 num2) public returns(uint256){
		uint256 result = num1 - num2;
		return result;
	}
	  
	function mult(uint num1, uint num2) public returns (uint){
		uint number = num1 * num2;
		return number;
	}
	
	function div(uint num1, uint num2) public returns (uint){
		if(num2 != 0){
			uint number = num1 / num2;
			return number;
		}
		else{
			return 0; 
		}
	}	
		
} 

contract CalculatorComplete is Calculator{
	 
	function factorial(uint number) public returns(uint256){
		if(number == 1){
			return 1; 
		}
		else{
			return number * factorial(number-1); 
		}
	}
	
	function greaterThan(uint number1,uint number2) public returns(uint256){
		if(number1 >= number2){
			return number1; 
		}
		else{
			return number2;
		}
	}
	
	function lessThan(uint number1,uint number2) public returns(uint256){
		if(number1 <= number2){
			return number1; 
		}
		else{
			return number2;
		}
	}
	
}
