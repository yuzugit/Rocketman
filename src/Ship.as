package{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	public class Ship extends MovieClip
	{
		var velocity:Number;
		var health:Number;
		var maxHealth:Number;
		
		public var xBuffer:int;
		public var yBuffer:int;
		
		function Ship()
		{
			velocity = 8;
			health = 100;
			maxHealth = 100;
			addEventListener("enterFrame", move);
			
			yBuffer = 30;
			xBuffer = 20;
		}
		
		function move(e:Event)
		{
			if(Key.isDown(Keyboard.UP) && y > yBuffer)
			{
				this.y = this.y - velocity;
				if(Game.ship.shield.visible == false)
				{
					Game.ship.takeDamage(0.1);
				}
			}
			
			if(Key.isDown(Keyboard.DOWN) && y < 590-yBuffer)
			{
				this.y = this.y + velocity;
				if(Game.ship.shield.visible == false)
				{
					Game.ship.takeDamage(0.1);
				}
			}
			
			if(Key.isDown(Keyboard.RIGHT) && x < 290-xBuffer)
			{
				this.x = this.x + velocity;
				Game.ship.scaleX = -1; 
				
				if(Game.ship.shield.visible == false)
				{
					Game.ship.takeDamage(0.1);
				}
			}
			
			if(Key.isDown(Keyboard.LEFT) && x > xBuffer)
			{
				this.x = this.x - velocity;
				Game.ship.scaleX = 1; 
				
				if(Game.ship.shield.visible == false)
				{
					Game.ship.takeDamage(0.1);
				}
			}
			
			if(shield.visible == true)
			{
				shield.alpha -= 0.0005;
				
				if(Game.ship.health < Game.ship.maxHealth)
				{
					Game.ship.takeDamage(-0.05);
				}
				
				if(Game.ship.health > Game.ship.maxHealth)
				{
					Game.ship.health = Game.ship.maxHealth
				}
					
				if(shield.alpha <= 0.1)
				{
					shield.visible = false;
					shield.alpha = 1;
				}
			}
		}
		
		function takeDamage(d)
		{
			health -= d;
			if(health <= 0)
			{
				health = 0;
				kill();
			}
			
			Game.healthMeter.bar.scaleX = health/maxHealth;
		}
		
		function kill()
		{
			var explosion = new Explosion();
			stage.addChild(explosion);
			explosion.x = this.x;
			explosion.y = this.y;
			removeEventListener("enterFrame", move);
			this.visible = false;
			Game.gameOver();
		}
		
	}
	
}