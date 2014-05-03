using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;

namespace UI48
{
	public class KeyInput: Node
	{
		GameManager _gm;
		Uno.UI.Canvas _gc;
		Uno.UI.TextBlock _score;
	    public KeyInput(GameManager gm, Uno.UI.Canvas gc, Uno.UI.TextBlock score)
	    {
			_gm = gm;
			_gc = gc;
			_score = score;
	        Uno.Scenes.Input.AddGlobalListener(this);
	    }

	    protected override void OnKeyDown(Uno.Scenes.KeyDownArgs e)
	    {
			switch (e.Key)
			{
				case Uno.Platform.Key.Up :
					_gm.Move(0);
					Refresh();
					break;

				case Uno.Platform.Key.Right :
					_gm.Move(1);
					Refresh();
					break;

				case Uno.Platform.Key.Down :
					_gm.Move(2);
					Refresh();
					break;

				case Uno.Platform.Key.Left :
					_gm.Move(3);
					Refresh();
					break;
			}
	    }
		
		float2 start;

		protected override void OnPointerDown(Uno.Scenes.PointerDownArgs args)
		{
			base.OnPointerDown(args);
			
			start = args.PointCoord;
		}

		protected override void OnPointerUp(Uno.Scenes.PointerUpArgs args)
		{
			base.OnPointerUp(args);
			
			float2 end = args.PointCoord;
			
			if (Math.Abs(dist.X) > Math.Abs(dist.Y))
			{
				// Horizontal
				if (Math.Abs(start.X - end.X) > 50) // It is a real swipe
					if (start.X > end.X)
					{
						_gm.Move(3); // Left
						Refresh();
					} else {
						_gm.Move(1); // Right
						Refresh();
					}
			} else {
				// Vertical
				if (Math.Abs(start.Y - end.Y) > 50) // It is a real swipe
					if (start.Y > end.Y)
					{
						_gm.Move(0); // Up
						Refresh();
					} else {
						_gm.Move(2); // Down
						Refresh();
					}
			}
			
		}



		public void Refresh()
		{
			_gc.Children.Clear();

			for (int y = 0; y < _gm._grid.Size; y++)
			{
				for (int x = 0; x < _gm._grid.Size; x++)
				{
					var t = _gm._grid.Map[y][x];
					if (t == null)
					{
						_gc.Children.Add(new TileElement()
						{
							X = x * 64 + spacing(x),
							Y = y * 64 + spacing(y),
							Tile = _gm.EmptyTile()
						});
					} else {
						var f = new TileElement()
						{
							X = t.Position.X * 64 + spacing(t.Position.X),
							Y = t.Position.Y * 64 + spacing(t.Position.Y),
							Tile = t
						};
						_gc.Children.Add(f);

						if (t.Merged == true)
						{
							f.Merge();
							t.Merged = false;
						}
					}
				}
			}
			_score.Text = _gm.score.ToString();
		}

		float spacing(int x)
		{
			return 15 + (10 * x);
		}
	}
}