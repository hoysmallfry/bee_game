package Src.Component
{
	public class Facet
	{		
		private var mOwner : GameObject;
		private var mSpecificName : String;
		private var mName : String;
		
		private const derive_error = Error("Derived facet must override base name.");
		
		public function Facet(pOwner : GameObject, pSpecificName:String)
		{
			mOwner = pOwner;
			mSpecificName = pSpecificName;
			mName = DeriveName(mSpecificName);
		}
		
		public function Owner() : GameObject
		{
			return mOwner;
		}
		
		public function BaseName() : String
		{
			throw derive_error;
		}
		
		public function SpecificName() : String
		{
			return mSpecificName;
		}
		
		public function Name() : String
		{
			return mName;
		}
		
		protected function DeriveName(pSpecificName : String) : String
		{
			throw derive_error;
		}
	}
}