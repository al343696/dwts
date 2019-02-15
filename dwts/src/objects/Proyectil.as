package objects 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author VyA
	 */
	public class Proyectil extends Sprite 
	{
		private var disparo:Image;
		public var vux:Number = 0, vuy:Number = 0;
		public var m:Number = 0;
		public var vel:Number = 20;
		public var masa:Number = 1;
		
		public function Proyectil() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			disparo = new Image(Assets.getTexture("Proyectil"));
			disparo.scale = 0.1;
			disparo.pivotX = disparo.width / 2;
			disparo.pivotY = disparo.height / 2;
			
			
			
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addChild(disparo);
			
		}
		
	}

}