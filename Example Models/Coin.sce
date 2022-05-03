pragma solidity ^0.4.0;
	
	contract Coin {
	// La palabra clave "public" hace que dichas variables puedan ser leídas desde fuera.
	address  public minter;//Persona que puede emitir/generar las monedas
	mapping (address => uint) public balances;
	
	 
	// Este es el constructor cuyo código sólo se ejecutará cuando se cree el contrato.
	constructor () public {
		minter = msg.sender;  
	}   
		 
	// Los eventos permiten a los clientes ligeros reaccionar de forma eficiente a los cambios.	
	event Sent(address _from, address _to, uint _amount);
		
	function mint(address receiver, uint amount) public {
		if (msg.sender != minter){
			return;
		} 
		balances[receiver] += amount;
	}  
	
	//Puede ser usado por todos (los que ya tienen algunas de estas monedas) para enviar monedas a cualquier otro
	function sendCoin(address receiver, uint amount)public {
		if (balances[msg.sender] < amount){
			return; //No puede enviar porque no tiene la cantidad que ha establecido para enviar (NO DISPONE DE FONDOS SUFICIENTES)
		} 
		balances[msg.sender] -= amount; //Se le resta la cantidad que va a enviar al emisor
		balances[receiver] += amount; //Se le suma la cantidad que va a recibir el destinatario
		Sent(msg.sender, receiver, amount); //Se notifica la acción de envío
	}
}
