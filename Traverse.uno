using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;

namespace UI48
{
	public class Traverse
	{
		public Traverse()
		{

		}

		public List<int> X = new List<int>();
		public List<int> Y = new List<int>();

		public void Add(int2 c)
		{
			X.Add(c.X);
			Y.Add(c.Y);
		}

		public List<List<int>> CombineTraverse()
		{
			var f = new List<List<int>>();
			f.Add(this.X);
			f.Add(this.Y);

			return f;
		}

		public List<int2> CombineTraverseInt2()
		{
			var f = new List<int2>();
			for (int i = 0; i < X.Count; i++)
			{
				f.Add(int2(X[i], Y[i]));
			}
			return f;
		}

		/**
		@VAR dir int x: 0, y: 1
		**/
		public void ReverseDir(int input)
		{
			switch(input)
			{
				case 0:
					var n = Reverse(X);
					X = n;
					break;
				case 1:
					var n = Reverse(Y);
					Y = n;
					break;

				default:
					break;
			}
		}

		List<int> Reverse(List<int> input)
		{
			var newlist = new List<int>();

			for (int i = input.Count - 1; i >= 0; i--)
			{
				newlist.Add(input[i]);
			}

			return newlist;
		}
	}
}