package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;	
	
	public class MainTrackSwitcher extends GrayscaleSwitcher {
		
		
		public function MainTrackSwitcher() {
			// constructor code
		}
		
		protected override function switchSelf (e:MouseEvent) {
			active = !active;
			this.updateSwitcher();
			InteractiveMap.sharedMap.setMainTrackVisibility(this.active);
		}
	}
	
}
