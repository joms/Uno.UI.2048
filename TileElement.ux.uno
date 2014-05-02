using Uno;
using Uno.Scenes;

public partial class TileElement
{
    public TileElement()
    {
        InitializeUX();

		//LoadAnimation.Play();
    }

    void Clicked(object a1, Uno.Scenes.PointerTappedArgs a2)
    {
		ClickAnimation.Play();
    }

	UI48.Tile _tile;
	public UI48.Tile Tile
	{
		get { return _tile; }
		set {
			if (value != _tile)
			{
				_tile = value;
				ValueBlock.Text = (_tile.Val > 1) ? _tile.Val.ToString() : "";
				TileBlock.Color = _tile.GetColor();
			}
		}
	}

	public void Merge()
	{
		ClickAnimation.Play();
	}
	
	public void FadeIn()
	{
		FadeInAnim.Play();
	}
}

