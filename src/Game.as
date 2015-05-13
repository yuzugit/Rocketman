package
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldType;


	public class Game extends MovieClip
	{
		static var ship:MovieClip;
		static var healthMeter:HealthMeter;
		static var gameOverMenu:GameOverMenu;
		static var mainMenu:MainMenu;
		static var enemyShipTimer:Timer;
		static var enemyhardTimer:Timer;
		static var powerUpTimer:Timer;
		
		static var easymode:Boolean = true;
		static var normalmode:Boolean = false;
		static var hardmode:Boolean = false;
		
		static var score:Number = 0;
        var scoreText:TextField = new TextField();
        var scoreTextFormat:TextFormat = new TextFormat("Calibri", 20,0xffffff ); 
		
		function Game()
		{
			mainMenu = new MainMenu();
			mainMenu.x = 150;
			mainMenu.y = 100;
			addChild(mainMenu);
			mainMenu.visible = true;
			mainMenu.startButton.addEventListener("mouseDown", initLevel);
			mainMenu.tutoButton.addEventListener("mouseDown", initTuto);
			
			var theme = new Theme();
			theme.play();
		}
		
		function initTuto(e:Event)
		{
			mainMenu.tuto.visible = true;
		}
		
		function initLevel(e:Event)
		{
			Key.initialize(stage);
			mainMenu.visible = false;
			ship = new Ship();
			addChild(ship);
			ship.x = 130;
			ship.y = 500;
			ship.shield.visible = false;
			
			enemyShipTimer = new Timer(800);
			enemyShipTimer.addEventListener("timer", sendEnemy);
			enemyShipTimer.start();
				
			powerUpTimer = new Timer(30000);
			powerUpTimer.addEventListener("timer", sendPowerUp);
			powerUpTimer.start();
			
			displayObjects(); 
			setUpEventListeners();
			
			resetScore();
			
			healthMeter = new HealthMeter();
			addChild(healthMeter);
			
			healthMeter.x = 10;
			healthMeter.y = 10;
			
			gameOverMenu = new GameOverMenu();
			gameOverMenu.x = 50;
			gameOverMenu.y = 150;
			addChild(gameOverMenu);
			gameOverMenu.visible = false;
			gameOverMenu.playAgainButton.addEventListener("mouseDown", newGame);
		}
		
		function displayObjects() 
		{
    
   			scoreText.type = TextFieldType.DYNAMIC;
    		scoreText.x = 70;
			scoreText.y = 3;
    		scoreText.width = 300;
			
        	scoreText.defaultTextFormat = scoreTextFormat;
    
   			addChild(scoreText);
		}
		
		function updateScore(evt:Event)
		{
    		scoreText.text = String(score);
			if(gameOverMenu.visible == false)
			{
				score++;
			}
			
			if(score >= 2000 && gameOverMenu.visible == false)
			{
				normalmode=true;
				easymode=false;
				score++;
			}
			
			if(score >= 10000 && gameOverMenu.visible == false)
			{
				normalmode=false;
				hardmode=true;
				score++;
			}
			
			if(Game.ship.health == Game.ship.maxHealth)
			{
				score++;
			}
		}
		static function malusScore(malus)
		{
			score -= malus;
		}
		
		static function bonusScore(bonus)
		{
			score += bonus;
		}
		
		function setUpEventListeners()
		{
			
			stage.addEventListener(Event.ENTER_FRAME, updateScore);
			
		}
		
		function sendEnemy(e:Event)
		{
			var enemy = new EnemyShip();
			stage.addChild(enemy);
		} 
		
		function sendPowerUp(e:Event)
		{
			var powerUp = new PowerUp();
			stage.addChild(powerUp);
		}
		
		static function resetScore()
		{
			score = 0;
		}
		
		static function gameOver()
		{
			gameOverMenu.visible = true;
			enemyShipTimer.stop();
			for(var i in EnemyShip.list)
			{
				EnemyShip.list[i].kill();
			}
		}
		
		function newGame(e:Event)
		{
			gameOverMenu.visible = false;
			ship.visible = true;
			ship.x = 150;
			ship.y = 500;
			ship.takeDamage(-ship.maxHealth);
			ship.addEventListener("enterFrame", ship.move);
			resetScore();
			enemyShipTimer.start();
			easymode = true;
			normalmode = false;
			hardmode = false;
		}
		
	}
	
}