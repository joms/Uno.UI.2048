using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;

namespace UI48
{
	public class GameManager
	{
		public Grid _grid;
		int startTiles = 2;
		
		public int score = 0;

		Random rand = simppafi.Utils.TimeRandom.GetRandom();

		public GameManager()
		{
			_grid = new Grid();
			AddStartTiles();
		}

		public Tile EmptyTile()
		{
			return new Tile(int2(0), 1);
		}

		void AddStartTiles()
		{
			for (int i = 0; i < startTiles; i++)
			{
				AddRandomTile();
			}
		}


		void AddRandomTile()
		{
			if (_grid.CellsAvailable())
			{
				int v = 2;
				if (rand.NextFloat() > 0.9f) { v = _grid.Size; }
				int2 t = _grid.RandomAvailableCell();

				if (t.X != -1 && t.Y != -1)
				{
					var nt = new Tile(t, v);
					_grid.InsertTile(nt);
				}
			}
		}

		void MoveTile(Tile t, int2 c)
		{
			int2 oldPos = t.Position;
			_grid.Map[oldPos.Y][oldPos.X] = null;
			_grid.Map[c.Y][c.X] = t;
			t.UpdatePosition(c);
		}

		public void Move(int direction)
		{
			var vector = GetVector(direction);
			var traverse = BuildTraversals(vector);
			var traversals = traverse.CombineTraverse();
			
			bool moved = false;
			
			for (int y = 0; y < traversals[1].Count; y++)
			{
				for (int x = 0; x < traversals[0].Count; x++)
				{
					var tile = _grid.CellContent(int2(x, y));
					
					if (tile != null)
					{
						var positions = FindFarthestPosition(int2(x, y), vector);
						var next = _grid.CellContent(positions[1]);
						
						if (next != null && next.Val == tile.Val)
						{
							var merged = new Tile(positions[1], tile.Val * 2, true);
							
							_grid.RemoveTile(tile);
							_grid.InsertTile(merged);
							
							tile.UpdatePosition(positions[1]);
							
							score += merged.Val;
							
						} else {
							MoveTile(tile, positions[0]);
						}
						
						if (!PositionsEqual(int2(x, y), tile.Position))
							moved = true;
					}
				}
			}
			
			if (moved)
			{
				AddRandomTile();
				moved = false;
			}
			//_grid.PrintMap();
		}

		int2 GetVector(int d)
		{
			int2[] map = new int2[]
			{
				int2(0, -1),
				int2(1, 0),
				int2(0, 1),
				int2(-1, 0)
			};

			return map[d];
		}
		
		Traverse BuildTraversals(int2 vec)
		{
			var t = new Traverse();
			
			for (int pos = 0; pos < _grid.Size; pos++)
			{
				t.Add(int2(pos));
			}
			
			if (vec.X == 1) t.ReverseDir(0);
			if (vec.Y == 1) t.ReverseDir(1);
			
			return t;
		}
		
		List<int2> FindFarthestPosition(int2 cell, int2 vector)
		{
			int2 previous;
			
			do {
				previous = cell;
				cell = int2(previous.X + vector.X, previous.Y + vector.Y);
			} while (
				_grid.WithinBounds(cell) && _grid.CellAvailable(cell)
			);
			
			var f = new List<int2>();
			f.Add(previous);
			f.Add(cell);
			
			return f;
		}
		
		bool PositionsEqual(int2 first, int2 second)
		{
			return first.X == second.X && first.Y == second.Y;
		}
	}
}