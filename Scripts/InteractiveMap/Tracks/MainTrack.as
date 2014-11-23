package  {
	
	import flash.display.MovieClip;
	
	
	public class MainTrack extends MovieClip {
		
		private var days:Array;
		
		public function MainTrack() {
			days = [];
			
   			for (var i:uint = 0; i < this.numChildren; i++)
				if (this.getChildAt(i) is TrackDay)
     				days.push(this.getChildAt(i));
		}
		
		public function deactivateAllDays ()
		{
			for (var i:uint = 0; i < days.length; i++)
				days[i].active = false;
		}
		
		public function updateAllDaysAnimated ()
		{
			for (var i:uint = 0; i < days.length; i++)
				days[i].updateState(true);
		}
	}
	
}
