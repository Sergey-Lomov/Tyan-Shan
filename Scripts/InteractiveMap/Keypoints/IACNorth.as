package  {
	
	import flash.display.MovieClip;
	
	
	public class IACNorth extends MapKeypoint {
		
		
		public function IACNorth() {
			this.articles = [IACNorthInfo, IACNorthStory1, IACNorthStory2, IACNorthStory3];
			this.initPrsentationTimeline();
			this.radius = 50;
		}
	}
	
}
