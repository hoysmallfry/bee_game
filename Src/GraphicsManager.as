package Src
{
	import flash.display.Stage;
	import flash.display.DisplayObject;
	
	import flash.geom.Matrix;
	
	import Src.Component.GameObject;
	import Src.Component.SceneFacet;
	
	public class GraphicsManager
	{
		// debug data.
		private var mStage:Stage;
		private var mScenes : Vector.<SceneFacet> = new Vector.<SceneFacet>();
		
		private var mViewportMatrix : Matrix;
		private var mStack : MatrixStack = new MatrixStack();
		
		public function GraphicsManager(pStage:Stage) 
		{
			mStage = pStage;
			
			const halfWidth : Number = mStage.stageWidth / 2.0;
			const halfHeight : Number = mStage.stageHeight / 2.0;
			
			mViewportMatrix = new Matrix(halfWidth, 0, 0, halfHeight, halfWidth, halfHeight);
		}

		public function AddScene(pOwner : GameObject, pSpecificName : String) : SceneFacet
		{
			var scene : SceneFacet = pOwner.AttachScene(pSpecificName, mStage);
			
			mScenes.push(scene);
			
			return scene;
		}
		
		public function FrameStart()
		{			
			mStack.Push(mViewportMatrix);
			
			for (var index in mScenes)
			{
				mScenes[index].FrameStart(mStack);
			}
			
			mStack.Pop();
		}
		
		public function FrameEnd()
		{			
			for (var index in mScenes)
			{
				mScenes[index].FrameEnd();
			}
		}
		
		public function Destroy()
		{
			for (var index in mScenes)
			{
				mScenes[index].Destroy();
			}
			
			mScenes = null;
		}
	}
}
