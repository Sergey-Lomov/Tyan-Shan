package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class KeypointsSwitcher extends GrayscaleSwitcher {
		
		
		public function KeypointsSwitcher() {
			
		}
		
		protected override function switchSelf (e:MouseEvent) {
			active = !active;
			this.updateSwitcher();
			InteractiveMap.sharedMap.setKeypointsVisibility(this.active);
		}
	}
	
}
