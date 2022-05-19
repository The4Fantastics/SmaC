pragma solidity ^0.8.0;

interface ISayHello {
    function getAge() external view returns (uint256);
    function setAge(uint256 _age) external ; 
    function makeMeSayHello() external view returns (string memory); 
}  

contract HelloAgain is ISayHello, { 
   
   uint256 public age; 
    function getAge() public pure override returns (uint256) {
      return 33;
   }
   function setAge(uint256 _age) public override {
      age = _age;
   }
   function makeMeSayHello() public pure override returns (string memory) {
      return "Hello again";
   }
   
}    