// SPDX-License-Identifier: MIT

/*1. Access Restriction
Concept:

Before execution of a function logic, there are certain conditions the caller must fulfill. 
* These conditions can be related to the caller’s identity, input parameters, contract state etc. 
* The function gets executed once all the requirements are met.
*In case the requirements aren’t met, the EVM handles the error by reverting the state, making no changes for the function call. 
* If a similar restriction is needed across multiple functions, a guard check can be utilized with modifiers. 
* Also, if you don’t want variables and functions to be available publicly, then protect their state data by opting for private visibility. */
pragma solidity ^0.8.0;
 
 
   /** 
    * @title An incremental time-bound donation receiver
    */
contract AccessRestriction {
   /**
    * @dev public variables in global, visible to everyone
    */
   address  public treasury = msg.sender;
   uint256 public creationTime = block.timestamp;
   uint256 public minimumDonation; 
   /**
    * @dev private visibility of winner address 
    */
   address  private winner;
 
   /**********Modifier Blocks********/
   /** 
    * @dev check if donation period has started
    */
   modifier onlyBefore(uint256 _time) {
       require(block.timestamp < _time);
       _;
   } 
 
    /**
    * @dev check if donation period has ended
    */
   modifier onlyAfter(uint256 _time) {
       require(block.timestamp > _time);
       _;
   }
 
   modifier isHigherDonation() {
       require(msg.value > minimumDonation, "Please send higher amount");
       winner = msg.sender;
       minimumDonation = msg.value; 
       _; 
   }
 
   function sendDonation() external onlyBefore(creationTime + 1 weeks) isHigherDonation  payable{
       payable(treasury).transfer(msg.value);
   }
 
   function revealHighestDonor() external onlyAfter(creationTime + 1 weeks) view returns (address ){
       return winner;
   }
}