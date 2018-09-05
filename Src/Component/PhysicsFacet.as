package Src.Component
{	
	import Box2D.Dynamics.*;
	import Box2D.Common.Math.*;
	
	import Src.Component.GameObject;
	import Src.Component.TransformFacet;
	import flash.geom.Point;
	
	public class PhysicsFacet extends Facet
	{		
		private static const base_name : String = "physics";
		
		private var mBody : b2Body;
		private var mTransform : TransformFacet;
		
		public static function derive_name(pSpecificName : String) : String
		{
			return base_name + "." + pSpecificName;
		}
		
		public function PhysicsFacet(pOwner : GameObject, pSpecificName : String, pBody : b2Body)
		{
			super(pOwner, pSpecificName);
			
			mBody = pBody;
			mTransform = Owner().AttachTransform(pSpecificName);
		}
		
		public override function BaseName() : String
		{
			return base_name;
		}
		
		public function ApplyCentralForce(pForce : b2Vec2)
		{
			ApplyForce(pForce, mBody.GetPosition());
		}
		
		public function ApplyForce(pForce : b2Vec2, pOrigin : b2Vec2)
		{
			mBody.ApplyForce(pForce, pOrigin);
		}
		
		public function Body()
		{
			return mBody;
		}
		
		public function Update(pRatio : uint)
		{
			mTransform.position.x = mBody.GetPosition().x * pRatio;
			mTransform.position.y = mBody.GetPosition().y * pRatio;
			
			mTransform.rotation = mBody.GetAngle();
		}
		
		protected override function DeriveName(pSpecificName : String) : String
		{
			return derive_name(pSpecificName);
		}
	}
}