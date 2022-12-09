pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";


/**
 * @title Energy Market
 * @notice Implements a simple energy market, using ERC20 and Whitelist.
 * ERC20 is used to enable payments from the consumers to the distribution
 * network, represented by this contract, and from the distribution network
 * to the producers. Whitelist is used to keep a list of compliant smart
 * meters that communicate the production and consumption of energy.
 */

contract Administered is AccessControl {
    
    
    bytes32 public constant USER_ROLE = keccak256("USER");

    /// @dev Add `root` to the admin role as a member.
    constructor () public {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setRoleAdmin(USER_ROLE, DEFAULT_ADMIN_ROLE);
    }

    /// @dev Restricted to members of the admin role.
    modifier onlyAdmin() {
        require(isAdmin(msg.sender), "Restricted to admins.");
        _;
    }

    /// @dev Restricted to members of the user role.
    modifier onlyUser() {
        require(isUser(msg.sender), "Restricted to users.");
        _;
    }

    /// @dev Return `true` if the account belongs to the admin role.
    function isAdmin(address account) public virtual  returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, account);
    }

    /// @dev Return `true` if the account belongs to the user role.
    function isUser(address account) public virtual  returns (bool) {
        return hasRole(USER_ROLE, account);
    }

    /// @dev Add an account to the user role. Restricted to admins.
    function addUser(address account) public  onlyAdmin virtual {
        grantRole(USER_ROLE, account);
    }

    /// @dev Add an account to the admin role. Restricted to admins.
    function addAdmin(address account) public onlyAdmin virtual  {
        grantRole(DEFAULT_ADMIN_ROLE, account);
    }

    /// @dev Remove an account from the user role. Restricted to admins.
    function removeUser(address account) public onlyAdmin virtual  {
        revokeRole(USER_ROLE, account);
    }

    /// @dev Remove oneself from the admin role.
    function renounceAdmin() public virtual {
        renounceRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }
} 


contract EnergyMarket is ERC20, Administered {

   
    // uint128 is used here to facilitate the price formula
    // Casting between uint128 and int256 never overflows
    // int256(uint128) - int256(uint128) never overflows
    mapping(uint256 => uint128) public consumption;
    mapping(uint256 => uint128) public production;
    uint128 public basePrice;

    /**
     * @dev The constructor initializes the underlying currency token and the
     * smart meter whitelist. The constructor also mints the requested amount
     * of the underlying currency token to fund the network load. Also sets the
     * maximum energy price, used for calculating prices.
     */
    constructor (uint256 _initialSupply, uint128 _basePrice)
        public
        ERC20("Energy", "POW")
    {
        _mint(address(this), _initialSupply);
        basePrice = _basePrice;
    }
    
    event EnergyProduced(address  producer, uint256 time);
    event EnergyConsumed(address consumer, uint256 time);
    

    /**
     * @dev The production price for each time slot.
     */
    function getProductionPrice(uint256 _time)
        public view virtual returns(uint256)
    {
    	
    	int256 price = int256(basePrice);
    	int totalTime = safeSub(production[_time], consumption[_time]);
    	totalTime = 3 + totalTime;
    	int totalPrice = price *  totalTime;
    	int maximo = max(0,totalPrice);
    	uint256 productionprice = uint256(maximo);
        return productionprice;

    }

    /**
     * @dev The consumption price for each time slot
     */
    function getConsumptionPrice(uint256 _time)
        public  view virtual  returns(uint256)
    {
     	int256 price = int256(basePrice);
    	int totalTime = safeSub(production[_time], consumption[_time]);
    	totalTime = 3 + totalTime;
    	int totalPrice = price *  totalTime;
    	int maximo = max(0,totalPrice);
    	uint256 productionprice = uint256(maximo);
        return productionprice;

    }

    /**
     * @dev Add one energy unit to the distribution network at the specified
     * time and be paid the production price. Only whitelisted smart meters can
     * call this function.
     */
    function produce(uint256 _time) public virtual {
        require(isUser(msg.sender), "Unknown meter.");
        this.transfer(
            msg.sender,
            getProductionPrice(_time)
        );
        production[_time] = production[_time] + 1;
        emit EnergyProduced(msg.sender, _time);
    }

    /**
     * @dev Take one energy unit from the distribution network at the specified
     * time by paying the consumption price. Only whitelisted smart meters can
     * call this function.
     */
    function consume(uint256 _time) public virtual {
        require(isUser(msg.sender), "Unknown meter.");
        this.transferFrom(
            msg.sender,
            address(this),
            getConsumptionPrice(_time)
        );
        consumption[_time] = consumption[_time] + 1;
        emit EnergyConsumed(msg.sender, _time);
    }

    /**
     * @dev Returns the largest of two numbers.
     */
    function max(int256 a, int256 b) internal pure returns (int256) {
        int256 maximo;
        if(a >= b){
        	maximo = a;
        }
        else{
        	maximo = b;
        }
        return maximo;
    }

    /**
     * @dev Substracts b from a using types safely casting from uint128 to int256.
     */
    function safeSub(uint128 a, uint128 b) internal pure returns (int256) {
        int256 a =  int256(a);
        int256 b = int256(b);
        return a - b;
    }
}