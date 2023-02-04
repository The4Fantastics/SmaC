pragma solidity ^0.8.7;

contract VendingMachine {

    // Declare state variables of the contract
    address  public owner;
    mapping (address => uint) public cupcakeBalances;
    address smartcontract;

    // When 'VendingMachine' contract is deployed:
    // 1. set the deploying address as the owner of the contract
    // 2. set the deployed smart contract's cupcake balance to 100
    constructor() public {
        owner = msg.sender;
        smartcontract = address(this);
        cupcakeBalances[smartcontract] = 100;
    }

    // Allow the owner to increase the smart contract's cupcake balance
    function refill(uint amount) public {
        require(msg.sender == owner, "Only the owner can refill.");
        cupcakeBalances[smartcontract] += amount;
    }

    // Allow anyone to purchase cupcakes
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 1 ether, "You must pay at least 1 ETH per cupcake");
        require(cupcakeBalances[smartcontract] >= amount, "Not enough cupcakes in stock to complete this purchase");
        cupcakeBalances[smartcontract] -= amount;
        cupcakeBalances[msg.sender] += amount;
    }
}
