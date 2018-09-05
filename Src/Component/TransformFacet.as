package Src.Component
{
	import flash.geom.*;
	import Box2D.Common.Math.*;
	
	public class TransformFacet extends Facet
	{
		public var scale : Point = new Point(1, 1);
		public var position : b2Vec2 = new b2Vec2();
		public var rotation : Number = 0;
		
		private static const base_name : String = "transform";
		
		public static function derive_name(pSpecificName : String) : String
		{
			return base_name + "." + pSpecificName;
		}
		
		public function TransformFacet(pOwner : GameObject, pSpecificName:String)
		{
			super(pOwner, pSpecificName);
		}
		
		public override function BaseName() : String
		{
			return base_name;
		}
		
		public function Matrix() : flash.geom.Matrix
		{
			var matrix : flash.geom.Matrix = new flash.geom.Matrix();
			
			matrix.scale(scale.x, scale.y);
			matrix.rotate(rotation);
			matrix.translate(position.x, position.y);
		
			return matrix;
		}
		
		protected override function DeriveName(pSpecificName : String) : String
		{
			return derive_name(pSpecificName);
		}
	}
}