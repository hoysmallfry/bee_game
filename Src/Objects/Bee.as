package Src.Objects
{
	import flash.ui.Keyboard;
	import flash.display.Stage;
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	import Src.*;
	import Src.Graphics.*;
	import Src.Component.GameObject;
	import Src.Component.PhysicsFacet;
	import Src.Component.TransformFacet;
	
	public class Bee extends GameObject
	{
		private var mPhysics : PhysicsFacet;;
		private var mTransform : TransformFacet;
		private var mCameraTransform : TransformFacet
		
		public function Bee(pObject : GameObject, pPosition : b2Vec2)
		{
			mCameraTransform = pObject.GetTransform("default");
			
			pObject.GetScene("main").AddObject(this, "wing", new Src.Graphics.BeeWing(), 6);
			pObject.GetScene("main").AddObject(this, "body", new Src.Graphics.BeeBody(), 5);
			mPhysics = Main.Physics().Add(this, "default", CreateBodyDefinition(pPosition), CreateFixtureDefinition());
			mTransform = GetTransform("default");
		}
		
		public function CreateFixtureDefinition() : b2FixtureDef
		{
			var circleshape : b2CircleShape = new b2CircleShape();
			circleshape.SetRadius(1.3);
			
			var fixturedef : b2FixtureDef = new b2FixtureDef();
			fixturedef.density = 0.5;
			fixturedef.restitution = 0.0;
			fixturedef.friction = 0.2;
			fixturedef.shape = circleshape;
			
			return fixturedef;
		}
		
		public function CreateBodyDefinition(pPosition : b2Vec2) : b2BodyDef
		{
			var bodydef:b2BodyDef = new b2BodyDef();
			bodydef.type = b2Body.b2_dynamicBody;
			bodydef.userData = "bee";
			bodydef.position = pPosition;
			bodydef.fixedRotation = true;
			
			return bodydef
		}
		
		public function Update()
		{
			if (Main.Input().IsPressed(Keyboard.LEFT))
			{
				mTransform.scale.x = -1;
				mPhysics.ApplyCentralForce(new b2Vec2(-15, 0));
			}
			
			if (Main.Input().IsPressed(Keyboard.RIGHT))
			{
				mTransform.scale.x = 1;
				mPhysics.ApplyCentralForce(new b2Vec2(15, 0));
			}
			
			if (Main.Input().IsPressed(Keyboard.UP))
			{
				mPhysics.ApplyCentralForce(new b2Vec2(0, -20));
			}
			
			mCameraTransform.position = mTransform.position;
		}
	}
}