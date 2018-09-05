package Src.States
{	
	import Src.*;
	import flash.ui.Keyboard;
	import flash.display.Stage;
	
	public class Level2 extends State
	{
		// Default constructor. Creates a state instance.
		public function Level2()
		{}

		// Updates all the objects inside a state and will contain all the checks that might restart/end a state.
		public override function Update()
		{
			if (Main.Input().IsTriggered(Keyboard.NUMBER_1))
				Main.GameState().GotoState(States.Level1);
				
			else if (Main.Input().IsTriggered(Keyboard.R))
				Main.GameState().GotoState(States.Restart);
				
			else if (Main.Input().IsTriggered(Keyboard.SPACE))
				Main.GameState().GotoState(States.Quit);
		}
	}
}