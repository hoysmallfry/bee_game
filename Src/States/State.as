/***************************************************************************************
	filename   	State.as 
	author		Elie Abi Chahine / Karim Fikani / Antoine Abi Chacra
	email   	eabichahine@digipen.edu / kfikani@digipen.edu / achacra@digipen.edu
	date		02/23/2012 
	
	Brief Description:
	  This class acts as the interface to all the other states. Every single state that
	  extends from this class should override all of its methods.        	 
***************************************************************************************/

package Src.States
{	
	import flash.display.Stage;

	public class State
	{
		// Contains all objects that have to be loaded when we reset the state.
		public function Initialize()
		{}

		// Updates all the objects inside a state and will contain all the checks that might restart/end a state.
		public function Update()
		{}

		// Removes all objects created in the initialize function.
		public function Uninitialize()
		{}

		// Destroys a state (objects, event listeners...)
		public function Destroy()
		{}
	}
}