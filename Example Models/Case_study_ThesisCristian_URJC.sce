// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.8.0;
 


interface EIP20Interface {
   

	/**
     * @dev Emitted when `value` tokens are moved _from one account (`_from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
	/**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
	

    function balanceOf(address _owner) external returns (uint256 _balance);
    function transfer(address _to, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

}


contract SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
            uint256 c = a + b;
            if (c < a){
            	 return (false, 0);
            }
            return (true, c);
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
            if (b > a){ 
            	return (false, 0);
            }
            return (true, a - b);
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0){
             return (true, 0);
            }
            uint256 c = a * b;
            uint256 result = c/a;
            if (result != b){ 
            	return (false, 0);
            }
            return (true, c);
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0){
        	 return (false, 0);
        }
        return (true, a / b);
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0){
        	 return (false, 0);
        }
        return (true, a % b);
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

}

//This smart contract is designed only for academic purposes


contract ECTSToken_Proposal_Thesis is EIP20Interface,SafeMath{
	
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private constant _name = "URECTS_Proposal_Thesis";
    string private constant _symbol =  "URECTS";
    uint8 private constant _decimals = 18;
    address  private _owner;
    enum State {Enable,Locked} //Control functionality access
    State control = State.Enable; //Default State enable

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The defaut value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor (uint256 amount) public{      
        _owner = msg.sender;
        _mint(msg.sender, amount);
    }

	modifier onlyOwner(){
		require(msg.sender == _owner, "Only owner can execute this action");
		_;
	}

    modifier isEnable(){
		require(control == State.Enable, "This action is disabled in this moment");
		_;
	}

     modifier isLocked(){
		require(control == State.Locked, "This action is enabled in this moment");
		_;
	}
    
    /**
     * @dev Returns the name of the token.
     */
    function name() public pure  returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public pure  returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public pure  returns (uint8) {
        return _decimals;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * Return the personal balance
     */
    function personalBalanceAccounts() public view  returns (uint256) {
    	address account = _msgSender();
        require(account != address(0), "ERC20: Invalid address");
        return _balances[account];
    }

     /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view  returns (uint256 balance) {
        require(account != address(0), "ERC20: Invalid address");
        balance =  _balanceOf(account);
        return balance;
    }


    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public  returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address delegate) public view  returns (uint256) {
        return _allowances[owner][delegate];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public  returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transfer_from}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public  returns (bool) {
        _transfer(sender, recipient, amount);
        address addr = _msgSender();
        uint256 currentAllowance = _allowances[sender][addr];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        _approve(sender, _msgSender(), currentAllowance - amount);

        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public  returns (bool) {
    	 address addr = _msgSender();
        _approve(_msgSender(), spender, _allowances[addr][spender] + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public  returns (bool) {
    	address addr = _msgSender();
        uint256 currentAllowance = _allowances[addr][spender];
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        _approve(_msgSender(), spender, currentAllowance - subtractedValue);

        return true;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function _balanceOf(address account) internal view  returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev Moves tokens `amount` _from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal isEnable {
        require(sender != address(0), "ERC20: transfer _from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        _beforeTokenTransfer(sender, recipient, amount);	
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);
    }


    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Calls to the function _mint.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     */
    function mint(address account, uint256 amount) public onlyOwner isEnable {
        require(account != address(0), "ERC20: transfer _from the zero address");
        _mint(account,amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `_from` set to the zero address.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal isEnable {
        _beforeTokenTransfer(address(0), account, amount);	
        _totalSupply += amount;
        _balances[account] += amount;
        //emit Transfer(address(0), account, amount);
    }
	
    /**
		* @dev Destroys `amount` tokens _from `account`, reducing the
		* total supply.
		*
		* Emits a {Transfer} event with `to` set to the zero address.
		*
		* Requirements:
		*
		* - `account` cannot be the zero address.
		* - `account` must have at least `amount` tokens.
		*/
	function burn(address account, uint256 amount) public isEnable onlyOwner {
        require(account != address(0), "ERC20: burn _from the zero address");
        uint256 accountBalance = _balances[account];
		require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
		_burn(account,amount);
	}

	/**
		* @dev Destroys `amount` tokens _from `account`, reducing the
		* total supply.
		*
		* Emits a {Transfer} event with `to` set to the zero address.
		*
		* Requirements:
		*
		* - `account` cannot be the zero address.
		* - `account` must have at least `amount` tokens.
		*/
	function _burn(address account, uint256 amount) internal isEnable onlyOwner  {
		_beforeTokenTransfer(account, address(0), amount);
        uint256 accountBalance = _balances[account];
		_balances[account] = accountBalance - amount;
		_totalSupply -= amount;

		//emit Transfer(account, address(0), amount);
	}

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal isEnable  {
        require(owner != address(0), "ERC20: approve _from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
		require(owner == _owner, "Address owner is not the real owner");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `_from` and `to` are both non-zero, `amount` of ``_from``'s tokens
     * will be to transferred to `to`.
     * - when `_from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``_from``'s tokens will be burned.
     * - `_from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address _from, address to, uint256 amount) internal isEnable { 
        require(amount > 0, "The amount cant be 0");
    }

    /*
    * @dev Change the contract status to Locked.
    * Calling conditions:
    * The user executing the function must be the owner of the contract, that is, the address that deployed said contract
    * The contract status must be Enable
    */
	function disableState() public onlyOwner isEnable {
        control = State.Locked;
    }

    /*
    * @dev Change the contract status to Enable.
    * Calling conditions:
    * The user executing the function must be the owner of the contract, that is, the address that deployed said contract
    * The contract status must be Locked
    */
    function enableState() public onlyOwner isLocked {
        control = State.Enable;
    }


    /**
    * @dev Provides information about the current execution context, including the
    * sender of the transaction and its data. While these are generally available
    * via msg.sender and msg.data, they should not be accessed in such a direct
    * manner, since when dealing with meta-transactions the account sending and
    * paying for execution may not be the actual sender (as far as an application
    * is concerned).
    *
    */
    function _msgSender() internal view  returns (address ) {
        return msg.sender;
    }

    function _msgData() internal pure  returns (bytes calldata) {
        return msg.data;
    }
    
}

	

