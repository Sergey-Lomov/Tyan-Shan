package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import flash.geom.Point;
	
	public class AutohideMovieClip extends MovieClip {

		protected var animationSpeed:Number = 0.7;
		protected var sensativeArea:MovieClip;
		protected var contentClip:MovieClip;

		public function AutohideMovieClip() {
			
		}
		
		protected function setup()
		{
			contentClip.alpha = 0;
			
			sensativeArea.addEventListener(MouseEvent.MOUSE_OVER, showContent);
			sensativeArea.addEventListener(MouseEvent.MOUSE_OUT, hideContent);
		}

		private function showContent (e:MouseEvent)
		{
			TweenMax.killTweensOf(contentClip);
			TweenMax.to(contentClip, animationSpeed, {alpha : 1});
			trace("Show conetnt");
		}
		
		private function hideContent (e:MouseEvent)
		{
			var mousePoint:Point = contentClip.localToGlobal(new Point(contentClip.mouseX,contentClip.mouseY));
			if (!contentClip.hitTestPoint(mousePoint.x,mousePoint.y,true))
			{
				TweenMax.killTweensOf(contentClip);
				TweenMax.to(contentClip, animationSpeed, {alpha : 0});
				trace("Hide content");
			}
		}
	}
	
}
