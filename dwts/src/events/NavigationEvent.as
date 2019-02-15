package events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Victor y Ana
	 */
	public class NavigationEvent extends Event 
	{
		
		public static const CHANGE_SCREEN:String = "changescreen";
		
		public var params:Object;
		
		public function NavigationEvent(type:String, _params:Object = null, bubbles:Boolean=false) 
		{
			super(type, bubbles);
			this.params = _params;
			
		}
		
	}

}