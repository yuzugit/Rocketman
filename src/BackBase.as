package{

	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class BackBase extends MovieClip
	{
		function BackBase()
		{
			addEventListener("enterFrame", enterFrame);
		}

		function enterFrame(e:Event)
		{
			this.y += 5;
		}

	}
	
}