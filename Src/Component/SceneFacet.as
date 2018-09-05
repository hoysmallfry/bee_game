package Src.Component
{		
	import flash.display.Stage;
	import flash.display.DisplayObject;
	
	import Src.MatrixStack;
	import Src.Component.GraphicsFacet;
	import Src.Component.CameraFacet;
	
	public class SceneFacet extends Facet
	{
		private static const base_name : String = "scene";
		
		private var mStage : Stage;
		private var mCamera : CameraFacet;
		private var mObjects : Vector.<GraphicsFacet> = new Vector.<GraphicsFacet>();
		
		public static function derive_name(pSpecificName : String) : String
		{
			return base_name + "." + pSpecificName;
		}
		
		public function SceneFacet(pOwner : GameObject, pSpecificName:String, pStage : Stage)
		{
			super(pOwner, pSpecificName);
			
			mStage = pStage;
			
			mCamera = pOwner.AttachCamera(pSpecificName);
			mCamera.SetAspectRatio(mStage.stageWidth / mStage.stageHeight);
		}
		
		public function AddObject(pOwner : GameObject, pSpecificName : String, pObject : DisplayObject, pDepth : int = 0) : GraphicsFacet
		{
			pObject.z = pDepth;
			var graphics = pOwner.AttachGraphics(pSpecificName, pObject);
			
			mObjects.push(graphics);
			
			function SortingFunc(pFirst : GraphicsFacet, pSecond : GraphicsFacet) : int
			{
				var first : Number = pFirst.DisplayObject().z;
				var second : Number = pSecond.DisplayObject().z;
				
				if (first == second)
				{
					return 0;
				}
				else if (first < second)
				{
					return -1;
				}
				
				return 1;
			}
			
			mObjects.sort(SortingFunc);
			
			for (var index in mObjects)
			{
				if(mStage.contains(mObjects[index].DisplayObject()))
					mStage.removeChild(mObjects[index].DisplayObject());
					
				mStage.addChild(mObjects[index].DisplayObject());
			}
			
			return graphics;
		}
		
		public function FrameStart(pStack : Src.MatrixStack)
		{
			pStack.Push(mCamera.ProjectionMatrix());
			pStack.Push(mCamera.ViewMatrix());
			
			for (var index in mObjects)
			{
				mObjects[index].Update(pStack);
			}
			
			pStack.Pop();
			pStack.Pop();
		}
		
		public function FrameEnd()
		{}
		
		public function Destroy()
		{
			for (var index in mObjects)
			{
				mStage.removeChild(mObjects[index].DisplayObject());
			}
			
			mObjects = null;
		}
		
		protected override function DeriveName(pSpecificName : String) : String
		{
			return derive_name(pSpecificName);
		}
	}
}