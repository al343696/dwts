package objects 
{
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.Event
	
	/**
	 * ...
	 * @author v y a
	 */
	public class Obstaculo extends Sprite 
	{
		private var tronco:Image;
		
		public function Obstaculo() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			tronco = new Image(Assets.getTexture("Tronco"));
			
			tronco.pivotX = tronco.width / 2;
			tronco.pivotY = tronco.height / 2;
			
			this.addChild(tronco);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
	}

}