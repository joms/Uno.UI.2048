using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;

namespace UI48
{
	public class Grid
	{
		public List<List<Tile>> Map = new List<List<Tile>>();
		Random rand = simppafi.Utils.TimeRandom.GetRandom();

		public readonly int Size = 4;

		public Grid()
		{
			Empty();
		}

		public void Empty()
		{
			for (int y = 0; y < Size; y++)
			{
				var row = new List<Tile>();
				for (int x = 0; x < Size; x++)
				{
					row.Add(null);
				}
				Map.Add(row);
			}
		}

		public int2 RandomAvailableCell()
		{
			List<int2> cells = AvailableCells();

			if (cells.Count > 0)
			{
				return cells[(int)(rand.NextFloat() * cells.Count)];
			} else {
				return int2(-1, -1);
			}
		}

		public List<int2> AvailableCells()
		{
			var cells = new List<int2>();

			for (int y = 0; y < Size; y++)
			{
				for (int x = 0; x < Size; x++)
				{
					if (Map[y][x] == null)
					{
						cells.Add(int2(x, y));
					}
				}
			}
			return cells;
		}

		public bool CellsAvailable()
		{
			if (AvailableCells().Count == 0)
			{
				return false;
			} else {
				return true;
			}
		}

		public bool CellAvailable(int2 c)
		{
			if (CellContent(c) == null && WithinBounds(c) == true)
			{
				return true;
			} else {
				return false;
			}
		}

		public bool CellOccupied(int2 c)
		{
			if (CellContent(c) != null)
			{
				return true;
			} else {
				return false;
			}
		}


		public Tile CellContent(int2 c)
		{
			if (WithinBounds(c))
			{
				return Map[c.Y][c.X];
			} else {
				return null;
			}
		}

		public bool WithinBounds(int2 c)
		{
			return c.X >= 0 && c.X < Size &&
				   c.Y >= 0 && c.Y < Size;
		}

		public void InsertTile(Tile t)
		{
			Map[t.Position.Y][t.Position.X] = t;
		}

		public void RemoveTile(Tile t)
		{
			Map[t.Position.Y][t.Position.X] = null;
		}

		public void PrintMap()
		{
			debug_log "--- Map start ---";

			for (int y = 0; y < Size; y++)
			{
				string s = "";
				for (int x = 0; x < Size; x++)
				{
					s += (Map[y][x] != null) ? Map[y][x].Val.ToString() + " " : "0 ";
				}
				debug_log s;
			}

			debug_log "--- Map end ---";
		}
	}
}