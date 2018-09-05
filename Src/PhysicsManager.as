package Src
{
	import flash.display.Stage;
	import flash.display.Sprite;
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	import Src.Component.GameObject;
	import Src.Component.PhysicsFacet;
	import Src.Component.GraphicsFacet;
	import Src.Component.SceneFacet;
	
	public class PhysicsManager
	{
		// constants.
		private const velocity_iter : uint = 10;
		private const position_iter : uint = 10;
		private const meter_to_pixel_ratio : uint = 15;
		
		// the physics world.
		private var mStage : Stage;
		private var mWorld : b2World;
		private var mObjects : Vector.<PhysicsFacet> = new Vector.<PhysicsFacet>();
		
		// debug data.
		private var mDebug = new Sprite();
		
		public function PhysicsManager(pStage : Stage) 
		{			
			mStage = pStage;
			mDebug.visible = true;
			
			// set the debug drawing properties.
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(mDebug);
			debugDraw.SetDrawScale(meter_to_pixel_ratio);
			debugDraw.SetFillAlpha(0.5);
			debugDraw.SetLineThickness(0.0);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);			
			
			// create gravity and sleep values.
			var v2Gravity:b2Vec2 = new b2Vec2(0, 4.0);
			var bDoSleep:Boolean = true;
			// create the physics world.
			mWorld = new b2World(v2Gravity, bDoSleep);
			// pass in the debug drawing properties.
			mWorld.SetDebugDraw(debugDraw);
		}

		public function GetDebug() : Sprite
		{
			return mDebug;
		}

		public function Add(pOwner : GameObject, pSpecificName : String, pBodyDefinition : b2BodyDef, pFixtureDefinition : b2FixtureDef) : PhysicsFacet
		{
			
			var body:b2Body = mWorld.CreateBody(pBodyDefinition);
			body.CreateFixture(pFixtureDefinition);
			
			var physics = pOwner.AttachPhysics(pSpecificName, body);
			
			mObjects.push(physics);
			
			return physics;
		}

		public function SetCollisionListener(pCallback : Function)
		{
			mWorld.SetContactListener(new CollisionListener(pCallback));
		}

		public function Update()
		{
			mWorld.Step(1.0 / mStage.frameRate, velocity_iter, position_iter);
			mWorld.ClearForces();
			
			for (var index in mObjects)
			{
				mObjects[index].Update(meter_to_pixel_ratio);
			}
			
			mWorld.DrawDebugData();
		}
		
		public function Destroy()
		{
			for (var index in mObjects)
			{
				mWorld.DestroyBody(mObjects[index].Body());
			}
			
			mObjects = null;
		}
	}
}

import Box2D.Dynamics.b2ContactListener;
import Box2D.Dynamics.Contacts.b2Contact;
import Box2D.Collision.b2Manifold;
import Box2D.Dynamics.b2ContactImpulse;

class CollisionListener extends b2ContactListener
{
	private var mOnBeginContact : Function;
	
	public function CollisionListener(pOnBeginContact : Function)
	{
		mOnBeginContact = pOnBeginContact;
	}

	public override function BeginContact(pContact : b2Contact) : void
	{
		var contactName1 = pContact.GetFixtureA().GetBody().GetUserData();
		var contactName2 = pContact.GetFixtureB().GetBody().GetUserData();
		
		mOnBeginContact(contactName1, contactName2);
	}
	public override function EndContact(pContact : b2Contact) : void
	{}
	
	public override function PreSolve(pContact : b2Contact, oldManifold : b2Manifold) : void
	{}
	
	public override function PostSolve(pContact : b2Contact, pImpulse : b2ContactImpulse) : void
	{}
}
