package  {
	
	import flash.display.MovieClip;

	public class InteractiveMap extends MovieClip {
				
		public static var sharedMap:InteractiveMap;
		
		const startScale:Number = 1;
		const startXDisplacement:Number = -50;
		const startYDisplacement:Number = 100;
		
		public var visibleElements
				
		public function InteractiveMap() {
			sharedMap = this;
			this.scaleX = this.scaleY = startScale;
			this.x += startXDisplacement;
			this.y += startYDisplacement;
			
			interactiveMapStub.alpha = 0;
		}
	}
	
}
