package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class EnemyShip extends MovieClip
	{
	
		var speed:Number;
		var rotate:Number;
		
		static var list:Array = new Array();
		
		function EnemyShip()
		{
			this.y -= 100;
			
			this.x = Math.random()*220 + 50;
			
			if(Game.easymode == true)
			{
				speed = Math.random()*5 + 10;
			}
			
			if(Game.normalmode == true)
			{
				speed = Math.random()*8 + 15;
			}
			
			if(Game.hardmode == true)
			{
				speed = Math.random()*15 + 20;
			}
			
			rotate = Math.random()*1 + 8;
			
			list.push(this);
			
			addEventListener("enterFrame", enterFrame);
		}
		
		function enterFrame(e:Event)
		{
			this.y += speed;
			this.rotation += rotate;
			if(this.y > 700)
			{
				kill();
				return;
			}
			
			
			
			if(this.hit.hitTestObject(Game.ship.hitbox))
			{	
				if(Game.ship.shield.alpha == 0 || Game.ship.shield.visible ==false)
				{
					Game.malusScore(100);
					Game.ship.takeDamage(30);
					var ps = new PointDisplay();
					ps.displayText.text = String(-100);
					ps.x = this.x;
					ps.y = this.y;
					stage.addChild(ps);
				}
		
				if(Game.ship.shield.alpha >= 0.1 && Game.ship.shield.visible ==true)
				{
					Game.bonusScore(250);
					
					if(Game.ship.health < Game.ship.maxHealth)
					{
						Game.ship.takeDamage(-5);
					}
					
					if(Game.ship.health > Game.ship.maxHealth)
					{
						Game.ship.health = Game.ship.maxHealth;
					}
					
					var pd = new PointDisplay();
					pd.displayText.text = String(250);
					pd.x = this.x;
					pd.y = this.y;
					stage.addChild(pd);
				}
				
				var explode = new ExploSound();
				explode.play();
				
				kill();
			}
			
		}
		
		function kill()
		{
			var explosion = new Explosion();
			stage.addChild(explosion);
			explosion.x = this.x;
			explosion.y = this.y;
			removeEventListener("enterFrame", enterFrame);
			stage.removeChild(this);
			
			for(var i in list)
			{
				if(list[i] == this)
				{
					delete list[i];	
				}
			}
		}
	}
}
		