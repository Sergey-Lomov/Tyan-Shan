package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class InteractiveMap extends MovieClip {
		
		private static var topRightPanelTopSpace:Number = 20;
		private static var topRightPanelRightSpace:Number = 20;
		public static var sharedMap:InteractiveMap = null;
		
		public function InteractiveMap() {
			if (sharedMap == null)
				sharedMap = this;
			
			this.addEventListener(Event.ADDED_TO_STAGE, setupToStage);
			
		}
		
		private function setupToStage (e:Event) {
			topRightPanel.x = stage.fullScreenWidth - this.x - topRightPanel.width - topRightPanelRightSpace;
			topRightPanel.y = - this.y + topRightPanelTopSpace;
		}
		
		public function activate() {
			mapContent.activate();
		}
	}
}
