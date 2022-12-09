// SPDX-License-Identifier: MIT
// By 0xAA
pragma solidity ^0.8.4;


contract Airdrop {

    function multiTransferToken(
        address _token,
        address [] calldata _addresses,
        uint256[] calldata _amounts
        ) external {
        require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
        IERC20 token = IERC20(_token);  
        uint _amountSum = getSum(_amounts);  
        require(token.allowance(msg.sender, address(this)) > _amountSum, "Need Approve ERC20 token");     
        for (uint256 i = 0; i < _addresses.length; i++) {
        	require(msg.sender.balance >= 2300 wei);
            token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
        }
    }

    function multiTransferETH(
        address payable[] calldata _addresses,
        uint256[] calldata _amounts
    ) public payable {
        require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL"); 
        require(msg.value == _amountSum, "Transfer amount error");
        for (uint256 i = 0; i < _addresses.length; i++) {
            require(msg.sender.balance >= 2300 wei);
            _addresses[i].transfer(_amounts[i]);
        }
    }


    function getSum(uint256[] calldata _arr) public pure returns(uint sum)
    {
        for(uint i = 0; i < _arr.length; i++){
        	require(msg.sender.balance >= 2300 wei);
            sum = sum + _arr[i];       	
        }
    }
}


// 
contract ERC20 {

    mapping(address => uint256) public  balanceOf;

    mapping(address => mapping(address => uint256)) public  allowance;

    uint256 public  totalSupply;  

    string public name;   
    string public symbol;  
    
    uint8 public decimals = 18; 
    
     address account = address(0);

    constructor(string memory name_, string memory symbol_) public{
        name = name_;
        symbol = symbol_;
    }
    
    // Triggered whenever approve(address _spender, uint256 _value) is called.
	event Approval(address indexed _owner, address indexed _spender, uint256 _value);
	 
	// Event triggered when tokens are transferred.
	event Transfer(address indexed _from, address indexed _to, uint256 _value);

  
    function transfer(address recipient, uint amount) external  returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }


    function approve(address spender, uint amount) external  returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }


    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external  returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }


    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        address A = address(0);
        emit Transfer(account, msg.sender, amount);
    }

 
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, account, amount);
    }

}