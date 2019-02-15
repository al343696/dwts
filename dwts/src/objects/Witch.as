package objects 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author v y a
	 */
	public class Witch extends Sprite 
	{
		private var bruja:Image;
		public var hp:int = 2000;
		public var vulnerable:Boolean = false;
		
		public function Witch() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			bruja = new Image(Assets.getTexture("Witch"));
			
			bruja.pivotX = bruja.width / 2;
			bruja.pivotY = bruja.height / 2;
			bruja.scale = 0.5;
			this.addChild(bruja);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function hit():void
		{
			this.hp -= 10;
		}
		
	}

}