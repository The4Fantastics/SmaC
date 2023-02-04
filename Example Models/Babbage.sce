pragma solidity ^0.4.10;
contract AdjustableSplitter {
	uint splitter_setting = 25;
	address controller = 0xac23628D25A36ba7834fd171Dc3F794F12A0C109;
	address exit1 = 0xfFD93fBFA184B6dfaaA8684B97Ec3F71dcfde8C6;
	address exit2 = 0xff5dad1Db92AF1987A10Fc62D2B93F14f6E0b112;
	
	function receiveEther() public payable {
		splitter_etherInjected(msg.value);
	}
	
	function splitter_etherInjected(uint amount) internal {
		uint setting = splitter_setting;
		uint amount_toLeft = amount * setting / 100;
		pipe1_etherInjected(amount_toLeft);
		pipe2_etherInjected(amount - amount_toLeft);
	}
	function splitter_adjustSetting(uint setting) internal {
		require(setting <= 100);
		splitter_setting = setting;
	}
	
	function pipe1_etherInjected(uint amount) internal {
		exit1.transfer(amount);
	}
	
	function pipe2_etherInjected(uint amount) internal {
		exit2.transfer(amount);
	}
	
	function rod1_moved(uint toSetting) public {
		require(msg.sender == controller);
		splitter_adjustSetting(toSetting);
	}
	
	function receive() public payable {
		receiveEther();
	}
}