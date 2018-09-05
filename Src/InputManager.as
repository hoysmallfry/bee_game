/***************************************************************************************
	filename   	InputManager.as 
	author		Elie Abi Chahine / Karim Fikani / Antoine Abi Chacra
	email   	eabichahine@digipen.edu / kfikani@digipen.edu / achacra@digipen.edu
	date		02/23/2012 
	
	Brief Description:
	  The input manager is reponsible for handeling all the keyboard events.        	 
***************************************************************************************/

package Src
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	public class InputManager
	{
		/* A reference to the main stage */
		private var sStage:Stage;
		/* An array that represents the status of all keys in the current game loop */
		private var keyPressed:Array;
		/* An array that represents the status of all keys in the previous game loop */
		private var keyWasPressed:Array;

		/*****************************************************************************
		   Function: InputManager
		
		Description: Constructor that initializes the input manager's variables
				     Each array holds 256 elements (size of the ascii table)
				     Keyboard event listeners should only be added to the stage
		
		     Inputs: sStage_: A reference to the stage
		
		    Outputs: None
		*****************************************************************************/
		public function InputManager(sStage_:Stage) 
		{			
			
			sStage = sStage_;
			
			keyPressed = new Array(256);
			keyWasPressed = new Array(256);
			
			sStage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
			sStage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
			
			for(var i:int = 0; i < 256; ++i)
			{
				keyPressed[i] = 0;
				keyWasPressed[i] = 0;
			}
		}

		/*****************************************************************************
		   Function: Update
		
		Description: Copying the current keys pressed to another array so we can keep
					 track of the keys pressed in the previous frame.
		
		     Inputs: None
		
		    Outputs: None
		*****************************************************************************/
		public function Update()
		{
			for(var i:int = 0; i < 256; ++i)
			{
				keyWasPressed[i] = keyPressed[i];
			}
		}

		/*****************************************************************************
		   Function: Destroy
		
		Description: This method destroys the Input Manager by removing all it's 
				     eventListeners and setting it's variables to null.
		
		     Inputs: None
		
		    Outputs: None
		*****************************************************************************/
		public function Destroy()
		{
			sStage.removeEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
			sStage.removeEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
			
			keyPressed = null;
			keyWasPressed = null;
		}

		/*****************************************************************************
		   Function: OnKeyDown
		
		Description: This method sets the pressed key's flag to 1 inside the array
		
		     Inputs: ke_: keyboard event containing all the keyboard information 
			 			  including which key was pressed by the user
						  
		    Outputs: None
		*****************************************************************************/
		private function OnKeyDown(ke_:KeyboardEvent)
		{
			keyPressed[ke_.keyCode] = 1;
		}

		/*****************************************************************************
		   Function: OnKeyUp
		
		Description: This method sets the released key's flag to 0 inside the array
		
		     Inputs: ke_: keyboard event containing all the keyboard information 
			 			  including which key was released by the user
		
		    Outputs: None
		*****************************************************************************/
		private function OnKeyUp(ke_:KeyboardEvent)
		{
			keyPressed[ke_.keyCode] = 0;
		}

		/*****************************************************************************
		   Function: IsPressed
		
		Description: This method checks if a key is pressed
		
		     Inputs: keyCode_: The code of the key we are checking 
		
		    Outputs: Return true if key is pressed, false otherwise.
		*****************************************************************************/
		public function IsPressed(keyCode_:int):Boolean
		{
			return keyPressed[keyCode_];
		}

		/*****************************************************************************
		   Function: IsTriggered
		
		Description: This method checks if a key is triggered
		
		     Inputs: keyCode_: The code of the key we are checking
		
		    Outputs: Return true if key is triggered, false otherwise.
		*****************************************************************************/
		public function IsTriggered(keyCode_:int) : Boolean
		{
			return keyPressed[keyCode_] && !keyWasPressed[keyCode_];
		}

		/*****************************************************************************
		   Function: IsReleased
		
		Description: This method checks if a key is released
		
		     Inputs: keyCode_: The code of the key we are checking
		
		    Outputs: Return true if key is released, false otherwise.
		*****************************************************************************/
		public function IsReleased(keyCode_:int) : Boolean
		{
			return !keyPressed[keyCode_] && keyWasPressed[keyCode_];
		}
	}
}
