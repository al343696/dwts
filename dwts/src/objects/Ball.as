package objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Ball extends Sprite
	{
		// data
		private var bola:Image;
		public var _velocityX:Number = 0;
		public var _velocityY:Number = 0;
		public var m:Number = 0;
		public var _speed:Number;
		public var _mass:Number;
		public var frezzed:Boolean = false;
	
		public function Ball() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		private function onAddedToStage(e:Event):void 
		{
			bola = new Image(Assets.getTexture("Ball"));
			bola.scale = 0.04;
			bola.pivotX = bola.width / 2;
			bola.pivotY = bola.height / 2;
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addChild(bola);
		}
		
		public function cambiaEstado():void
		{
			this.frezzed = !this.frezzed;
		}
	}
	
}