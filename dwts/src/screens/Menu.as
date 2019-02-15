package screens 
{
	import events.NavigationEvent;
	import mx.core.ButtonAsset;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author v y a
	 */
	public class Menu extends Sprite 
	{
		private var bg:Image;
		private var Playbutton:Button;
		private var CtrlButton:Button;
		private var Lvl1:Button;
		private var Lvl2:Button;
		private var Lvl3:Button;
		
		
		public function Menu() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
		}
		
		private function onAddedToStage(event:Event):void{
			trace("Menu screen initialized");
			
			drawScreen();
		}
		private function drawScreen():void{
			
			bg = new Image(Assets.getTexture("BgWelcome"));
			this.addChild(bg);
			
			Lvl1 = new Button(Assets.getTexture("Lvl1"));
			Lvl1.x = 400;
			Lvl1.y = 225;
			Lvl1.scale = 0.4;
			this.addChild(Lvl1);
			
			Lvl2 = new Button(Assets.getTexture("Lvl2"));
			Lvl2.x = 500;
			Lvl2.y = 350;
			Lvl2.scale = 0.4;
			this.addChild(Lvl2);
			
			Lvl3 = new Button(Assets.getTexture("Lvl3"));
			Lvl3.x = 600;
			Lvl3.y = 475;
			Lvl3.scale = 0.4;
			this.addChild(Lvl3);
			
			this.addEventListener(Event.TRIGGERED, clicEnBoton);
		}
		
		private function clicEnBoton(event:Event):void
		{
			var buttonCLicked:Button = event.target as Button;
			
			if ((buttonCLicked as Button) == Lvl1)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			}
			else if ((buttonCLicked as Button) == Lvl2)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play2"}, true));
			}
			else if ((buttonCLicked as Button) == Lvl3)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play3"}, true));
			}
		}
	}

}