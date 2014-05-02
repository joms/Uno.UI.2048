using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;

namespace UI48
{
	public class Tile
	{
		public int2 Position { get; private set; }
		public int Val { get; set; }
		public bool Merged { get; set; }
		
		bool newtile = true;

		List<float4> colors = new List<float4>();

		public Tile(int2 position, int val = 2, bool merged = false)
		{
			Position = position;
			Val = val;
			Merged = merged;

			colors.Add(float4(1, 1, 1, 0.25f));
			colors.Add(float4(1, 1, 1, 0.5f));
			colors.Add(float4(1, 1, 1, 0.75f));

			colors.Add(float4(0, 1, 1, 0.25f));
			colors.Add(float4(0, 1, 1, 0.5f));
			colors.Add(float4(0, 1, 1, 0.75f));

			colors.Add(float4(1, 0, 1, 0.25f));
			colors.Add(float4(1, 0, 1, 0.5f));
			colors.Add(float4(1, 0, 1, 0.75f));

			colors.Add(float4(1, 1, 0, 0.25f));
			colors.Add(float4(1, 1, 0, 0.5f));
			colors.Add(float4(1, 1, 0, 0.75f));

		}

		public void UpdatePosition(int2 position)
		{
			Position = position;
		}

		public float4 GetColor()
		{
			try {
				return colors[(int)Math.Log2(Val)];
			} catch {
				return float4(1, 0, 1, 1);
			}
		}
		
		public bool IsNew()
		{
			if (newtile == true)
			{
				newtile = false;
				return true;
			} else {
				return false;
			}
		}
	}
}