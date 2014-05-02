using Uno;
using Uno.Collections;
using Uno.Graphics;
using Uno.Scenes;
using Uno.Content;
using Uno.Content.Models;

namespace simppafi.Utils
{
    public static class TimeRandom
    {
        private static Uno.Random rand;
        public static Uno.Random GetRandom()
        {
            if(rand == null)
            {
				var arr = Uno.Diagnostics.Clock.GetSeconds().ToString().Split(new [] {(char)(',')});
                if(arr.Length == 1)
                {
					arr = Uno.Diagnostics.Clock.GetSeconds().ToString().Split(new [] {(char)('.')});
                }
                var seed = Uno.Int.Parse(arr[1]);
                rand = new Uno.Random(seed);
            }
            return rand;
        }
    }
}