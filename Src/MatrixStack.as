package Src
{
	import flash.geom.Matrix;
	
	public class MatrixStack
	{
		private var mStack : Vector.<Matrix> = new Vector.<Matrix>();
		
		public function MatrixStack()
		{
			mStack.push(new Matrix());
		}
		
		public function Top() : Matrix
		{
			return mStack[mStack.length - 1];
		}
		
		public function Push(pMatrix : Matrix)
		{
			var matrix : Matrix = pMatrix.clone();
			matrix.concat(Top());
			
			mStack.push(matrix);
		}
		
		public function Pop()
		{
			mStack.pop();
		}
	}
}