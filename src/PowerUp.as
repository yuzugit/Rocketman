package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class PowerUp extends MovieClip
	{
		var speed:Number;
		var type:Number;
		
		function PowerUp()
		{
			speed = 2;
			this.y -= 10;
			this.x = Math.random()*200+10;
			addEventListener("enterFrame", enterFrame);
		}
		
		function enterFrame(e:Event)
		{
			this.y += speed;
			
			if(this.hitTestObject(Game.ship.hitbox))
			{		
				Game.ship.shield.visible=true;
			
				Game.bonusScore(200);
				
				var pd = new PointDisplay();
				pd.displayText.text = String(200);
				pd.x = this.x;
				pd.y = this.y;
				stage.addChild(pd)
				
				removeEventListener("enterFrame", enterFrame);
				stage.removeChild(this);
				
				var bonus = new bonuSound();
				bonus.play();
			}
			
			if(this.y > 630 )
			{
				removeEventListener("enterFrame", enterFrame);
				stage.removeChild(this);
			}
			
		}
	}
}