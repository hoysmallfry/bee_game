/***************************************************************************************
	filename   	Main.as 
	author		Elie Abi Chahine / Karim Fikani / Antoine Abi Chacra
	email   	eabichahine@digipen.edu / kfikani@digipen.edu / achacra@digipen.edu
	date		02/23/2012 
	
	Brief Description:
	  This is the starting point of the game engine. This class's main objective is to 
	  initialize, destroy and update the game engine compoenents. Other responsibilities 
	  is to provide with the game loop.     	 
***************************************************************************************/

package
{
	import Src.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		// triggers the engine's destructiond when set to true.
		static public var bExitGame:Boolean = false;
		
		static private var mInputs : Src.InputManager;
		static private var mGraphics : Src.GraphicsManager;
		static private var mPhysics : Src.PhysicsManager;
		static private var mStates : Src.GameStateManager;
		
		/// Default constructor.
		public function Main()
		{			
			// creates the input manager and the game state manager.
			mInputs = new Src.InputManager(stage);
			mGraphics = new Src.GraphicsManager(stage);
			mPhysics = new Src.PhysicsManager(stage);
			mStates = new Src.GameStateManager();
			
			// create game loops.
			stage.addEventListener(Event.ENTER_FRAME, GameLoop);
			stage.addEventListener(Event.EXIT_FRAME, GameLoopExit);
		}
		
		static public function Input() : Src.InputManager
		{
			return mInputs;
		}
		
		static public function Physics() : Src.PhysicsManager
		{
			return mPhysics;
		}

		static public function GameState() : Src.GameStateManager
		{
			return mStates;
		}

		static public function Graphics() : Src.GraphicsManager
		{
			return mGraphics;
		}
		
		// performs game loop functionality.
		private function GameLoop(e_:Event)
		{
			if(bExitGame)
			{
				Destroy();
				return;
			}
			
			mPhysics.Update();
			mStates.Update();
			mGraphics.FrameStart();
		}

		// updates the input manager.
		private function GameLoopExit(e_:Event)
		{
			mGraphics.FrameEnd();
			mInputs.Update();
		}

		/// Destroys all engine components.
		private function Destroy()
		{
			mInputs.Destroy();
			mPhysics.Destroy();
			mStates.Destroy();
			mGraphics.Destroy();
			
			mInputs = null;
			mPhysics = null;
			mStates = null;
			mGraphics = null;
			
			stage.removeEventListener(Event.ENTER_FRAME, GameLoop);
			stage.removeEventListener(Event.EXIT_FRAME, GameLoopExit);
		}
	}
}