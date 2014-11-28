package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.*;
	import com.greensock.easing.Linear;
	import flash.geom.Point;
	
	
	public class MapKeypoint extends MovieClip {
		
		protected var hint:MovieClip;
		protected var main:MovieClip;
		public var active:Boolean = false;
		private var lastUpdatedState:Boolean = false;
		
		protected var articles:Array;
		
		protected var radius:Number = 100;
		protected var animationSpeed:Number = 0.3;
		protected var hintPresentationDuration:Number = 1.0;
		protected var intersubAngle:Number = 35;
		
		private var presentationTimeline:TimelineLite = new TimelineLite ();
		
		public function MapKeypoint() {
			main = MovieClip(this.getChildByName("mainClip"));
			main.addEventListener(MouseEvent.CLICK, changeState);
			hint = MovieClip(this.getChildByName("hintClip"));
			
			hint.alpha = 0;
			this.removeChild(hint);
		}
		
		public function initPrsentationTimeline () {
			var center:Point = new Point(0, 0);
			for (var i:int = 0; i < articles.length; i++)
			{
				presentationTimeline.to(articles[i], animationSpeed, {y : radius}, animationSpeed * i);
				if (i != articles.length - 1) {
					var maxDegree:Number = (articles.length - i - 1) * intersubAngle;
					presentationTimeline.add(TweenMax.to(articles[i], animationSpeed * (articles.length - i - 1), {bezier:[{x:circlePoint(center,radius,90).x, y:circlePoint(center,radius,90).y},
																															{x:circlePoint(center,radius,90+maxDegree / 4).x, y:circlePoint(center,radius,90+maxDegree / 4).y},
																															{x:circlePoint(center,radius,90+maxDegree / 2).x, y:circlePoint(center,radius,90+maxDegree / 2).y},
																														 	{x:circlePoint(center,radius,90+maxDegree / 4 * 3).x, y:circlePoint(center,radius,90+maxDegree / 4 * 3).y},
																															{x:circlePoint(center,radius,90+maxDegree).x, y:circlePoint(center,radius,90+maxDegree).y}], 
																													ease:Linear.easeNone}), animationSpeed * (i + 1));
				}
			}
			
			for (i = 0; i < articles.length; i++)
			{
				var curAngle:Number = (articles.length - i - 1) * intersubAngle;
				var stepAngle:Number = intersubAngle * (articles.length - 1) / 8;
				presentationTimeline.add(TweenMax.to(articles[i], animationSpeed / 2 * articles.length, {bezier:[{x:circlePoint(center,radius,90+curAngle).x, y:circlePoint(center,radius,90+curAngle).y},
																							 					{x:circlePoint(center,radius,90+curAngle-stepAngle).x, y:circlePoint(center,radius,90+curAngle-stepAngle).y},
																												{x:circlePoint(center,radius,90+curAngle-stepAngle*2).x, y:circlePoint(center,radius,90+curAngle-stepAngle*2).y},
																						 						{x:circlePoint(center,radius,90+curAngle-stepAngle*3).x, y:circlePoint(center,radius,90+curAngle-stepAngle*3).y},
																												{x:circlePoint(center,radius,90+curAngle-stepAngle*4).x, y:circlePoint(center,radius,90+curAngle-stepAngle*4).y}],  
																										ease:Linear.easeNone}), animationSpeed * (articles.length + 1));
			}
			
			presentationTimeline.pause();
		}
		
		private function changeState (e:MouseEvent) {
				active = !active;
				this.updateState(true);
		}
		
		public function updateState (animated:Boolean) {
			if (active == lastUpdatedState)
				return;
			
			lastUpdatedState = active;
			
			if (presentationTimeline != null)
				if (active)
					presentationTimeline.play();
				else
					presentationTimeline.reverse();

			if (hint != null) {
				TweenMax.killTweensOf(hint);
				
				if (active) {
					if (hint.parent == null)
						this.addChild(hint);
					TweenMax.to(hint, hintPresentationDuration, {alpha : 1});
				}
				else
					TweenMax.to(hint, hintPresentationDuration, {alpha : 0, onCompleteParams:[this], onComplete:
					function (self:MapKeypoint):void
					{
						self.removeChild(hint);
					}});;
			}
		}
		
		private function circlePoint(center:Point, radius:Number, degree:Number) : Point {
			return new Point(center.x + Math.cos(0.01745 * degree) * radius,
							 center.y + Math.sin(0.01745 * degree) * radius);
		}
	}
	
}
