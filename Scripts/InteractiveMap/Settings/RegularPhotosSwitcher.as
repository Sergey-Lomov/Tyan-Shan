package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class RegularPhotosSwitcher extends GrayscaleSwitcher {
		
		
		public function RegularPhotosSwitcher() {
			// constructor code
		}
		
		protected override function switchSelf (e:MouseEvent) {
			active = !active;
			this.updateSwitcher();
			InteractiveMap.sharedMap.setRegularPhotosVisibility(this.active);
		}
	}
	
}
