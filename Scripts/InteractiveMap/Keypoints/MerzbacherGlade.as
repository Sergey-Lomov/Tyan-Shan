package  {
	
	import flash.display.MovieClip;
	
	
	public class MerzbacherGlade extends MapKeypoint {
		
		
		public function MerzbacherGlade() {
			this.articles = [MerzbacherGladeInfo, MerzbacherGladeStory1, MerzbacherGladeStory2, MerzbacherGladeStory3, MerzbacherGladeStory4];
			this.initPrsentationTimeline();
			this.radius = 50;
		}
	}
	
}
