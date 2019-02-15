package objects 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Archer extends Sprite 
	{
		private var arquera:Image;
		
		public function Archer() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	
		}
		
		private function onAddedToStage():void
		{
			arquera = new Image(Assets.getTexture("hero"));
			
			arquera.pivotX = arquera.width / 2;
			arquera.pivotY = arquera.height / 2;
			arquera.scale = 2;

			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addChild(arquera);
		}
		

		
	}

}