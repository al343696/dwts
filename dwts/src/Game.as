package 
{
	import events.NavigationEvent;
	import screens.InGame;
	import screens.InGame2;
	import screens.InGame3;
	import screens.Menu;
	import screens.Welcome;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Victor y Ana
	 */
	public class Game extends Sprite 
	{
		private var screenWelcome:Welcome;
		private var screenInGame:InGame;
		private var screenInGame2:InGame2;
		private var screenInGame3:InGame3;
		private var screenMenu:Menu;
		public static var PuntuacionTotal:int = 0;
		
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void{
			trace("Starling framework initialized!"); 
			
			screenWelcome = new Welcome();
			this.addChild(screenWelcome);
			//screenWelcome.initialize();
			screenWelcome.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);	
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch(event.params.id)
			{
				case "welcome":
					//screenInGame.disposeTemporarily();
					this.removeChild(screenInGame);
					

					screenWelcome = new Welcome();
					screenWelcome.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
					this.addChild(screenWelcome);
					//screenWelcome.initialize();
					break;
					
				case "play":
					//screenWelcome.disposeTemporarily();
					this.removeChild(screenWelcome);
					this.removeChild(screenMenu);
					
					screenInGame = new InGame();
					screenInGame.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
					this.addChild(screenInGame);
					//screenInGame.initialize();
					break;
					
				case "play2":
					//screenWelcome.disposeTemporarily();
					this.removeChild(screenWelcome);
					this.removeChild(screenMenu);
					
					screenInGame2 = new InGame2();
					screenInGame2.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
					this.addChild(screenInGame2);
					//screenInGame.initialize();
					break;
					
				case "play3":
				//screenWelcome.disposeTemporarily();
				this.removeChild(screenWelcome);
				this.removeChild(screenMenu);
				
				screenInGame3 = new InGame3();
				screenInGame3.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
				this.addChild(screenInGame3);
				//screenInGame.initialize();
				break;
					
				case "menu":
					//screenInGame.disposeTemporarily();
					this.removeChild(screenInGame);
					this.removeChild(screenInGame2);
					this.removeChild(screenInGame3);
					this.removeChild(screenWelcome);
					

					screenMenu = new Menu();
					screenMenu.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
					this.addChild(screenMenu);
					//screenWelcome.initialize();
					break;
			}
		}
	}

}