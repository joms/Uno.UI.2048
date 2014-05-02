using Uno;
using Uno.Collections;
using Uno.Scenes;
using UI48;

public partial class Scene1
{
	GameManager gm;
	KeyInput k;

	public Scene1()
	{
		InitializeUX();
		GameCanvas.Children.Clear();

		gm = new GameManager();
		k = new KeyInput(gm, GameCanvas, Score);
		
		k.Refresh();
	}

	float spacing(int x)
	{
		return 15 + (10 * x);
	}
}
