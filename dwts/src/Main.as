package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import screens.InGame;
	import screens.Welcome;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Victor y Ana
	 */
	[SWF(width="800", height="600", framerate="50", backgroundColor="#00b3b3")]

	public class Main extends Sprite 
	{
		private var theStarling:Starling;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			theStarling = new Starling(Game, stage);
			theStarling.antiAliasing = 2;
			theStarling.start();
		}
		
	}
	
}