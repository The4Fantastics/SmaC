pragma solidity >=0.4.22 <0.7.0;

library Balances {
    
    function move(mapping(address => uint256) _balances, address _from, address to, uint amount) internal {
        require(balances[_from] >= amount);
        require(balances[to] + amount >= balances[to]);
        _balances[_from] -= amount;
        _balances[to] += amount;
    }
}


contract Token {
    mapping(address => uint256) balances;
    using Balances for *;
    mapping(address => mapping (address => uint256)) allowed;

    event Transfer(address _from, address to, uint amount);
    event Approval(address owner, address spender, uint amount);

    function balanceOf(address tokenOwner) public view returns (uint _balance) {
        return balances[tokenOwner];
    }
    function transfer(address to, uint amount) public returns (bool success) {
        balances.move(msg.sender, to, amount);
        emit Transfer(msg.sender, to, amount);
        return true;
 
    }

    function transferFrom(address _from, address to, uint amount) public returns (bool success) {
        require(allowed[_from][msg.sender] >= amount);
        allowed[_from][msg.sender] -= amount;
        balances.move(_from, to, amount);
        emit Transfer(_from, to, amount);
        return true;
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        require(allowed[msg.sender][spender] == 0, "");
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
}