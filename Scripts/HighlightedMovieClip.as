package  
{
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import com.greensock.*;
	import flash.filters.GlowFilter;
	
	public class HighlightedMovieClip extends MovieClip
	{
		public var animationSpeed:Number = 0.8;
		public var maxBlurX:Number = 20;
		public var maxBlurY:Number = 20;
		public var maxStrength:Number = 2.5;
		public var maxAlpha:Number = 1;
		public var minBlurX:Number = 20;
		public var minBlurY:Number = 20;
		public var minStrength:Number = 2.5;
		public var minAlpha:Number = 0;
		public var color:uint = 0xFFFF00;
		
		private var glowFilter:GlowFilter;
		
		public function HighlightedMovieClip()
		{
			glowFilter = new GlowFilter(color, minAlpha, minBlurX, minBlurY, minStrength, 2);
			this.filters = new Array(glowFilter);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverCallback);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutCallback);
		}

		private function mouseOverCallback(e:MouseEvent)
		{
			TweenMax.to(this, animationSpeed, {glowFilter:{alpha:maxAlpha, strength:maxStrength, blurX:maxBlurX, blurY:maxBlurY}});
		}
		
		private function mouseOutCallback(e:MouseEvent)
		{
			TweenMax.to(this, animationSpeed, {glowFilter:{alpha:minAlpha, strength:minStrength, blurX:minBlurX, blurY:minBlurY}});
		}
	}	
}
