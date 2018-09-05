package Src.Component
{
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.DisplayObject;
	
	import Box2D.Dynamics.*;
	
	public class GameObject
	{
		public function AttachTransform(pSpecificName : String) : TransformFacet
		{
			return (TransformFacet)(Attach(new TransformFacet(this, pSpecificName)));
		}
		public function GetTransform(pName:String) : TransformFacet
		{
			return (TransformFacet)(Get(TransformFacet.derive_name(pName)));
		}
		
		public function AttachPhysics(pSpecificName : String, pBody : b2Body) : PhysicsFacet
		{
			return (PhysicsFacet)(Attach(new PhysicsFacet(this, pSpecificName, pBody)));
		}
		public function GetPhysics(pName:String) : PhysicsFacet
		{
			return (PhysicsFacet)(Get(PhysicsFacet.derive_name(pName)));
		}
		
		public function AttachScene(pSpecificName : String, pStage : Stage) : SceneFacet
		{
			return (SceneFacet)(Attach(new SceneFacet(this, pSpecificName, pStage)));
		}
		public function GetScene(pName:String) : SceneFacet
		{
			return (SceneFacet)(Get(SceneFacet.derive_name(pName)));
		}
		
		public function AttachCamera(pSpecificName : String) : CameraFacet
		{
			return (CameraFacet)(Attach(new CameraFacet(this, pSpecificName)));
		}
		public function GetCamera(pName:String) : CameraFacet
		{
			return (CameraFacet)(Get(CameraFacet.derive_name(pName)));
		}
		
		public function AttachGraphics(pSpecificName : String, pObject : DisplayObject) : GraphicsFacet
		{
			return (GraphicsFacet)(Attach(new GraphicsFacet(this, pSpecificName, pObject)));
		}
		public function GetGraphics(pName:String) : GraphicsFacet
		{
			return (GraphicsFacet)(Get(GraphicsFacet.derive_name(pName)));
		}
		
		////
		private var mFacets:Dictionary = new Dictionary();
		
		private function Attach(pFacet : Facet) : Facet
		{
			if (!mFacets.hasOwnProperty(pFacet.Name()))
			{
				mFacets[pFacet.Name()] = pFacet;
			}
			
			return mFacets[pFacet.Name()];
		}
		
		private function Get(pName : String) : Facet
		{
			return mFacets[pName];
		}
		
		private function Detach(pName : String)
		{
			delete mFacets[pName];
		}
	}
}