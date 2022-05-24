// Solidity program to demonstrate
// DApps

pragma solidity ^0.5.11;

// Smart Contract for the Voting application
contract VotingForTopper {

	// Refer to the owner
	address owner;

	// Declaring the public variable 'purpose' to demonstrate the purpose of voting
	string public purpose;
	
	// Defining a structure with boolean variables authorized and voted
	struct Voter{
		bool authorized;
		bool voted;
	}

	// Declaring the unsigned integer variables totalVotes, and for the 3 teams- A,B, and C
	uint totalVotes;
	uint teamA;
	uint teamB;
	uint teamC;
	
	// Creating a mapping for the total Votes
	mapping(address => Voter) info;

	// Defining a constructor indicating the purpose of voting
	constructor(string memory _name) public{
		purpose = _name;
		owner = msg.sender;
	}
	
	// Defining a modifier to verify the ownership
	modifier ownerOn() {
		require(msg.sender==owner);
		_;
	}
	
	// Defining a function to verify the person is voted or not
	function authorize(address _person) public ownerOn  {
		info[_person].authorized= true;
		
	}
	
	// Defining a function to check and skip the code if the person is already
	// voted else allow to vote and calculate totalvotes for team A
	function temaAF(address _address) public {
		require(!info[_address].voted,"Already voted person");
		require(info[_address].authorized,"You Have No Right for Vote");
		info[_address].voted = true;
		teamA++;
		totalVotes++;
	}

	// Defining a function to check and skip the code if the person
	// is already voted else allow to vote and calculate totalvotes for team B
	function temaBF(address _address) public {
		require(!info[_address].voted,"Already voted person");
		require(info[_address].authorized,"You Have No Right for Vote");
		teamB++;
		info[_address].voted = true;
		totalVotes++;
	}

	// Defining a function to check
	// and skip the code if the person
	// is already voted else allow to vote
	// and calculate totalvotes for team C
	function temaCF(address _address) public returns(string){
		require(!info[_address].voted,"Already voted person");
		require(info[_address].authorized,"You Have No Right for Vote");
		info[_address].voted = true;
		teamC++;
		totalVotes++;
		return("Thanks for Voting");
	}

	function totalVotesF() public view returns(uint){
		return totalVotes;
	}

	// Defining a function to announce
	// the result of voting and
	// the name of the winning team
	function resultOfVoting() public view returns(string){
		if(teamA>teamB && teamA>teamC){
			return "A is Winning";
		} 
		if(teamA>teamB && teamC>teamA){ 
			return "C is Winning"; 
		}
		if(teamB>teamC) {
			return "B is Winning";
		}
		if(teamA==teamB && teamA==teamC || teamB==teamC ){
			return "No One is Winning";
		}
	}
}