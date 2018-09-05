package Src.States
{	
	import flash.ui.Keyboard;
	import flash.display.Stage;
	import flash.display.Sprite;
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	import Src.*;
	import Src.Objects.Bee;
	import Src.Component.GameObject;
	import Src.Component.SceneFacet;
	import Src.Objects.PinkFlower;
	
	public class Level1 extends State
	{
		private var mHero : Bee;
		private var mFlower : PinkFlower;
		
		private var mGround : GameObject = new GameObject;
		
		private var mScene : GameObject = new GameObject();
		private var mDebug : GameObject = new GameObject();
		
		// Default constructor. Creates a state instance.
		public function Level1()
		{						
			// set up main scene.
			var mainScene = Main.Graphics().AddScene(mScene, "main");
			var mainCamera = mScene.GetCamera("main");
			mainCamera.SetFOVY(400);
			mainScene.AddObject(mDebug, "default", Main.Physics().GetDebug(), 100);
			
			// set up the bee.
			mHero = new Bee(mScene, new b2Vec2(0, 0));
			// set up the pink flower.
			mFlower = new PinkFlower(mScene, new b2Vec2(2.5, 5.0));
			
			// set up the ground
			// create shape.
			var polygonshapeGround:b2PolygonShape = new b2PolygonShape();
			polygonshapeGround.SetAsBox(18.33, .33);
			
			var fixturedefGround:b2FixtureDef = new b2FixtureDef();
			fixturedefGround.density = 0.0;
			fixturedefGround.restitution = 0.2;
			fixturedefGround.friction = 0.5;
			fixturedefGround.shape = polygonshapeGround;
			
			// create body definition.
			var bodydefGround:b2BodyDef = new b2BodyDef();
			bodydefGround.type = b2Body.b2_staticBody;
			bodydefGround.userData = "ground";
			bodydefGround.position.Set(18.33, 25.33);
			
			Main.Physics().Add(mGround, "default", bodydefGround, fixturedefGround);
			Main.Physics().SetCollisionListener(Contact);
		}

		// Updates all the objects inside a state and will contain all the checks that might restart/end a state.
		public override function Update()
		{			
			mHero.Update();
			
			if (Main.Input().IsTriggered(Keyboard.D))
			{
				var displayObject = mDebug.GetGraphics("default").DisplayObject()
				displayObject.visible = !displayObject.visible;
			}
		}
		
		private function Contact(pName1 : String, pName2 : String)
		{
			//trace(pName1 + ", " + pName2);
		}
	}
}