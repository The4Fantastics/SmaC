pragma solidity ^0.4.0;

contract bankAccount {
	
	enum StateEnum {Inactivated, Activated,Deposit, Withdraw}
	StateEnum State;
 	int32 transaction_input;
 	int32 balance;
 	
 	constructor() public {
		State = StateEnum.Inactivated;
		executeStateEntryAction();
 	}
 
 	function activateAccount() public {
		if (State == StateEnum.Inactivated) {
			executeStateExitAction();
			State = StateEnum.Activated;
			executeStateEntryAction();
		} else {
			executeStateDuringAction();
		}
	}
 	
 	function deposit() public {
		if (State == StateEnum.Activated) {
			executeStateExitAction();
			State = StateEnum.Deposit;
			executeStateEntryAction();
		} else {
			executeStateDuringAction();
		}
 	}
 	
 	function executeStateEntryAction() internal {
		if (State == StateEnum.Inactivated) {
			balance = int32(0);
		}
	}

	function executeStateDuringAction() internal {}

	function executeActivatedEntryAction() internal {
		if (State == StateEnum.Inactivated) {
			balance = int32(0);
			State = Activated;
		}
	}
	 
 	function executeStateExitAction() internal {
		if (State == StateEnum.Deposit) {
			balance = balance + transaction_input;
		} 
		if (State == StateEnum.Withdraw) {
			balance = balance - transaction_input;
		}
	}
	
	function displayData() public returns (int32, int32) {
		return (transaction_input, balance);
 	}
 	
} 