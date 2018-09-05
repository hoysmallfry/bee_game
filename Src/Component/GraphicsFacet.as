package Src.Component
{
	import flash.display.DisplayObject;

	import Src.MatrixStack;
	import Src.Component.TransformFacet;
	import flash.geom.Matrix;

	public class GraphicsFacet extends Facet
	{
		private static const base_name : String = "graphics";
		
		private var mDisplayObject : flash.display.DisplayObject;
		private var mTransform : TransformFacet;
		
		public static function derive_name(pSpecificName : String) : String
		{
			return base_name + "." + pSpecificName;
		}
		
		public function GraphicsFacet(pOwner : GameObject, pSpecificName : String, pObject : flash.display.DisplayObject)
		{
			super(pOwner, pSpecificName);
			
			mDisplayObject = pObject;
			mTransform = Owner().AttachTransform("default");
		}
		
		public override function BaseName() : String
		{
			return base_name;
		}
		
		public function DisplayObject() : flash.display.DisplayObject
		{
			return mDisplayObject;
		}
		
		public function Update(pStack : MatrixStack)
		{
			pStack.Push(mTransform.Matrix())
			
			// changes the movieclip's transform matrix.
			mDisplayObject.transform.matrix = pStack.Top();
			
			pStack.Pop();
		}
		
		protected override function DeriveName(pSpecificName : String) : String
		{
			return derive_name(pSpecificName);
		}
	}
}