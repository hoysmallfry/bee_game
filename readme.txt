Controls:

Use D to toggle debug.

Up arrow to fly upwards.
Left arrow to fly left.
Right arrow to fly right.

If the game is laggy, turn the quality down to low.

----

What I set out to do:

I focused on making a component-based engine. We have GameObjects, which are the
component container, and Facets which are the components. A facet can't exist without
a GameObject that owns it. I chose the name "facets" because can be stand alone, or
they can be a piece of a more complex system. For instance, we can have a CameraFacet
that has PhysicsFacet attached to it, and a GraphicsFacet that moves with it, like my
the Bee does.

All Facets that are meant to occupy space in the game also implicitly create a facet
that can transform them, called a TransformFacet. If multiple facets that make a
TransformFacet are attached to the same GameObject, then they will reference one and
the same TransformFacet.

I wanted to start work on a general pupose actionscript engine, one that I could use
for other potential projects.

----

What I made for this project:

There are four managers: GraphicsManager, PhysicsManager, InputManager
and GameStateManager.

The GraphicsManager controls an abstraction called "scenes". Scenes are a collection
of renderable items and a camera they render in reference to. In order to make a the
objects move in respect to the camera they share, I created a MatrixStack class.

In addition to transformation data, the CameraFacet class has information regarding
its aspect ratio, and its Y axis field of view, and generates a simple orthographic
projection matrix, allowing us to have a camera that can zooms in if need be.

The when creating a renderable item (GraphicsFacet) in the scene
(see SceneFacet.AddObject), the user can specify the DisplayObject and the depth of
the object. Using the depth value, it sorts the object so that when placed on the stage,
it places it in an order where high numbers are drawn closest to the screen.

PhysicsManager uses Box2D as the base architecture. With Add, it creates a PhysicsFacet,
using a fixture and body definition.

----

What I learned:

I learned some extra information regarding Box2D that wasn't presented, such as
figuring how to make a dynamic object that didn't rotate (like the bee), and how to
make objects with ghost collision (such as the pollen area on the flower).

I also learned how to use some of flash's animation and tools. The wings of the bee,
for insance, are separate GraphicsFacets from the body, and flap on a loop.
The background image was done mostly with Flash's Deco Tool, which procedurally
creates art.

----

What I had trouble with:

Figuring out how to use the physics debug draing working right. It wasn't so much
about getting it to work - thats simple. What was difficult was trying to design
the engine so that it did not step over the boundaries of what GraphicsManager is
meant to do.

The other problem was that I needed to get the physics scaling right
as well, because the physics portion was affecting the graphics portion via the
TransformFacet. During the physics update, the PhysicsFacets changed the values of
their TransformFacets, and in turn during the graphics update, the TrasformFacets
affected the placement of the GraphicsFacets on the screen.
