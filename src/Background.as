package{

	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Background extends MovieClip
	{
		function Background()
		{
			addEventListener("enterFrame", enterFrame);
		}

		function enterFrame(e:Event)
		{
			this.y += 5;
			if(this.y > 2110)
			{
				this.y = 0;
			}
		}

	}
	
}