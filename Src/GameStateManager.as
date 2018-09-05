package Src
{
	import flash.display.Stage;
	import flash.events.Event;
	import Src.States.*;
	
	public class GameStateManager
	{
		// An integer that keeps track of the game state manager's current step.
		private var mSteps:int;
		
		// Keeps track of the current state.
		private var mCurrentIndex:int;
		
		// Keeps track of the next state.
		static private var mNextIndex:int;
		
		// A state instance that gives us access to the current state's public properties.
		private var mState:State;
				
		public function GameStateManager()
		{			
			mCurrentIndex = States.Level1;
			mNextIndex = States.Level1;
			
			CreateState();
			// Initialize the current game state.
			mState.Initialize();
		}
		
		public function Update()
		{	
			// Update the game state.
			mState.Update();
			
			// if not equal, then we are changing states.
			if (mCurrentIndex != mNextIndex)
			{
				if(mNextIndex == States.Quit)
				{
					Main.bExitGame = true;
					return;
				}
				// Uninitialize the state.
				mState.Uninitialize();
			
				// if not restarting, then destroy state.
				if(mNextIndex == States.Restart)
				{
					mNextIndex = mCurrentIndex;
				}
				else
				{
					mState.Destroy();
					CreateState();
				}
				
				// Initialize the current game state.
				mState.Initialize();
			}
			
			// next is now current
			mCurrentIndex = mNextIndex;
		}
		
		public function GotoState(pNextIndex:int)
		{
			mNextIndex = pNextIndex;
		}
		
		private function CreateState()
		{
			// Switches to the appropriate states.
			switch (mNextIndex)
			{
				case States.Level1 :
					mState = new Src.States.Level1();
					break;
		
				case States.Level2 :
					mState = new Src.States.Level2();
					break;
			}
		}
		
		public function Destroy()
		{
			mState.Uninitialize();
			mState.Destroy();
		}

	}
}