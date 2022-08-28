// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.24;

contract Purchase {
    uint public value;
    uint public minimum;
    address  public seller;
    address  public buyer;

    enum State { Created, Locked, Release, Inactive }
    // The state variable has a default value of the first member "State.Created".
    State public state;

   

    // Ensure that "msg.value" is an even number.
    // Division will truncate if it's an odd number. Check via multiplication that it wasn't an odd number.
    constructor() public payable {
        seller = msg.sender;
        value = msg.value / 2;    
        minimum =  2 * value; 
        require(msg.value == minimum, "The value has to be even.");
    }

	 modifier condition(bool _condition) {
        require(_condition);
        _;
    }

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only the buyer can call this functionality.");
        _;
    }
    
    modifier onlySeller() {
        require(msg.sender == seller, "Only the seller can call this functionality.");
        _;
    }

    modifier inState(State _state) {
        require(state == _state, "Invalid state.");
        _;
    }

    event Aborted();
    event PurchaseConfirmed();
    event ItemReceived();
    event SellerRefunded();

    /// Abot the purchase and reclaim the ether.
    /// This function can only be called by the seller befire the contract is Locked.
    function abort() public onlySeller inState(State.Created) {
        emit Aborted();
        state = State.Inactive;
        // We use transer here directly. It's reentrancy-safe, because it's the last call in this function and we already changed the state.
        seller.transfer(address(this).balance);
    }

    /// Confirm the purchase as buyer. The transaction has to include "value * 2" ether.
    /// The ether will be locked until the function confirmItemReceived is called.
    function confirmPurchase() public inState(State.Created) condition(msg.value == minimum) payable {
        emit PurchaseConfirmed();
        buyer = msg.sender;
        state = State.Locked;
    }

    /// Confirm that you (the buyer) received the item. This will release the locked ether.
    function confirmItemReceived() public onlyBuyer inState(State.Locked) {
        emit ItemReceived();
        // It's important to change the state first because otherwise, the contracts called using "send" bellow can call in again here.
        state = State.Release;
        buyer.transfer(value);
    }

    /// This function refunds the seller.
    /// i.e. pays back the locked funds of the seller. 
    function refundSeller() public onlySeller inState(State.Release) {
        emit SellerRefunded();
        state = State.Inactive;
        // It's important to change the state first because otherwise the contracts called using "send" bellow can call in again here.
        seller.transfer(value * 3);
    }
}