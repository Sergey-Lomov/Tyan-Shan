package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	
	
	public class TopRightPanel extends MovieClip {
				
		protected const animationDuration:Number = 1.0;
				
		public function TopRightPanel() {
			showHistoryButton.addEventListener(MouseEvent.CLICK, showHistory);
			showSettingsButton.addEventListener(MouseEvent.CLICK, showSettings);
			defaultZoomButton.addEventListener(MouseEvent.CLICK, setDefaultZoom);
		}
		
		public function setToMapMode (animated:Boolean = true) {
			TweenMax.killTweensOf(showHistoryButton);
			TweenMax.killTweensOf(showSettingsButton);
			TweenMax.killTweensOf(defaultZoomButton);
			if (animated) {
				TweenMax.to(showHistoryButton, animationDuration, {alpha : 1});
				TweenMax.to(showSettingsButton, animationDuration, {alpha : 1});
				TweenMax.to(defaultZoomButton, animationDuration, {alpha : 1});
			}
			else {
				showHistoryButton.alpha = 1;
				showSettingsButton.alpha = 1;
				defaultZoomButton.alpha = 1;
			}
		}
		
		public function setToHistoryMode (animated:Boolean = true) {
			TweenMax.killTweensOf(showHistoryButton);
			TweenMax.killTweensOf(showSettingsButton);
			TweenMax.killTweensOf(defaultZoomButton);
			if (animated) {
				TweenMax.to(showHistoryButton, animationDuration, {alpha : 0});
				TweenMax.to(showSettingsButton, animationDuration, {alpha : 0});
				TweenMax.to(defaultZoomButton, animationDuration, {alpha : 0});
			}
			else {
				showHistoryButton.alpha = 0;
				showSettingsButton.alpha = 0;
				defaultZoomButton.alpha = 0;
			}
		}
		
		private function showHistory (e:MouseEvent) {
			InteractiveMap.sharedMap.deactivate();
			HistoryWorkspaceController.sharedHistoryWorkspace.presentSelf();
		}
		
		private function showSettings (e:MouseEvent) {
			stage.addChild(MapSettings.sharedMapSettings());
		}
		
		private function setDefaultZoom (e:MouseEvent) {
			InteractiveMap.sharedMap.restoreZoom();
		}
	}
}
