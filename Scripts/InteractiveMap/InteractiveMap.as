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
			topRightPanel.setToHistoryMode(false);
		}
		
		private function setupToStage (e:Event) {
			topRightPanel.x = stage.fullScreenWidth - this.x - topRightPanelRightSpace;
			topRightPanel.y = - this.y + topRightPanelTopSpace;
		}
		
		public function activate() {
			mapContent.activate();
			topRightPanel.setToMapMode();
		}
		
		public function deactivate() {
			mapContent.deactivate();
			topRightPanel.setToHistoryMode();
		}
		
		public function restoreZoom () {
			mapContent.restoreZoom();
		}
		
		public function setMainTrackVisibility (visibility:Boolean) {
			mapContent.setMainTrackVisibility(visibility);
		}
		
		public function setRegularPhotosVisibility (visibility:Boolean) {
			mapContent.setRegularPhotosVisibility(visibility);
		}
		
		public function setKeypointsVisibility (visibility:Boolean) {
			mapContent.setKeypointsVisibility(visibility);
		}
		
		public function keypointsVisibility () : Boolean {
			return mapContent.keypointsVisibility;
		}
		
		public function regularPhotosVisibility () : Boolean {
			return mapContent.regularPhotosVisibility;
		}
		
		public function mainTrackVisibility () : Boolean {
			return mapContent.mainTrackVisibility;
		}
	}
}
