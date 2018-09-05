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
	
	public class PinkFlower extends GameObject
	{
		private var mPhysics : PhysicsFacet;;
		
		public function PinkFlower(pObject : GameObject, pPosition : b2Vec2)
		{
			pObject.GetScene("main").AddObject(this, "flower", new Src.Graphics.PinkFlower());
			pObject.GetScene("main").AddObject(this, "stem", new Src.Graphics.FlowerStem1());
			
			mPhysics = Main.Physics().Add(this, "default", CreateBodyDefinition(pPosition), CreateFixtureDefinition());
			
			var polygonshapeGround:b2PolygonShape = new b2PolygonShape();
			polygonshapeGround.SetAsBox(5, 1);
			
			var fixturedef:b2FixtureDef = new b2FixtureDef();
			fixturedef.density = 0.0;
			fixturedef.restitution = 0.2;
			fixturedef.friction = 0.5;
			fixturedef.shape = polygonshapeGround;
			
			// create body definition.
			var bodydef:b2BodyDef = new b2BodyDef();
			bodydef.type = b2Body.b2_staticBody;
			bodydef.userData = "ground";
			bodydef.position.Set(pPosition.x, pPosition.y + 2);
			
			mPhysics = Main.Physics().Add(this, "pedals", bodydef, fixturedef);
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
			fixturedef.isSensor = true;
			
			return fixturedef;
		}
		
		public function CreateBodyDefinition(pPosition : b2Vec2) : b2BodyDef
		{
			var bodydef:b2BodyDef = new b2BodyDef();
			bodydef.type = b2Body.b2_staticBody;
			bodydef.userData = "pink flower";
			bodydef.position = pPosition;
			
			return bodydef
		}
	}
}