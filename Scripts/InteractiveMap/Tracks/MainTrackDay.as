package  {
	import fl.motion.Color;
	import flash.display.MovieClip;
	
	public class MainTrackDay extends TrackDay{

		public function MainTrackDay() {
			this.defaultColor = new Color (0, 80 ,0);
			this.highlightedColor = new Color (0, 160, 0);
			
			this.updateState(false);
		}

	}
	
}
