package Src.Component
{	
	import flash.geom.Matrix;
	
	public class CameraFacet extends Facet
	{
		private static const base_name : String = "camera";
		
		private var mTransform : TransformFacet;
		private var mAspectRatio : Number = 1;
		private var mFovY : Number = 1;
		
		public static function derive_name(pSpecificName : String) : String
		{
			return base_name + "." + pSpecificName;
		}
		
		public function CameraFacet(pOwner : GameObject, pSpecificName:String)
		{
			super(pOwner, pSpecificName);
			
			mTransform = Owner().AttachTransform("default");
		}
		
		public override function BaseName() : String
		{
			return base_name;
		}
		
		public function GetAspectRatio() : Number
		{
			return mAspectRatio;
		}
		public function SetAspectRatio(pValue : Number)
		{
			mAspectRatio = pValue;
		}
		
		public function GetFOVY() : Number
		{
			return mFovY;
		}
		public function SetFOVY(pValue : Number)
		{
			mFovY = pValue;
		}
		
		public function ProjectionMatrix() : Matrix
		{
			var width : Number = mFovY * mAspectRatio;
			var height : Number = mFovY;
			return new Matrix(2.0 / width, 0, 0, 2.0 / height);
		}
		
		public function ViewMatrix() : Matrix
		{
			var matrix : Matrix = mTransform.Matrix().clone();
			matrix.invert();
			
			return matrix;
		}
		
		protected override function DeriveName(pSpecificName : String) : String
		{
			return derive_name(pSpecificName);
		}
	}
}