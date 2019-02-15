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
	 * @author Victor y Ana 
	 */
	public class Welcome extends Sprite 
	{
		private var bg:Image;
		private var Playbutton:Button;
		private var CtrlButton:Button;
		
		public function Welcome() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
			
		}
		
		private function onAddedToStage(event:Event):void{
			trace("Welcome screen initialized");
			
			drawScreen();
		}
		private function drawScreen():void{
			
			bg = new Image(Assets.getTexture("BgWelcome"));
			this.addChild(bg);
			
			Playbutton = new Button(Assets.getTexture("PlayButton"));
			Playbutton.x = 400;
			Playbutton.y = 225;
			Playbutton.scale = 0.7;
			this.addChild(Playbutton);
			
			CtrlButton = new Button(Assets.getTexture("CrtlButton"));
			CtrlButton.x = 500;
			CtrlButton.y = 400;
			CtrlButton.scale = 0.7;
			this.addChild(CtrlButton);
			
			this.addEventListener(Event.TRIGGERED, clicEnBoton);
		}
		
		private function clicEnBoton(event:Event):void
		{
			var buttonCLicked:Button = event.target as Button;
			
			if ((buttonCLicked as Button) == Playbutton)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "menu"}, true));
			}
		}
		
		public function initialize():void{
			this.visible = true;
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		
	}

}