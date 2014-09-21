package  {
	
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import flash.filters.GlowFilter;
	import flash.display.MovieClip;
	import com.greensock.events.TweenEvent;
	
	public class GlowHighlightedReference extends MovieClip
	{
		public var referenceTargetIdentifier:String;
		
		public var animationSpeed:Number = 1.5;
		public var maxBlurX:Number = 15;
		public var maxBlurY:Number = 15;
		public var maxStrength:Number = 2;
		public var maxAlpha:Number = 1;
		public var minBlurX:Number = 5;
		public var minBlurY:Number = 5;
		public var minStrength:Number = 1;
		public var minAlpha:Number = 1;
		public var color:uint = 0xFFFF00;
		
		private var glowFilter:GlowFilter;

		public function GlowHighlightedReference()
		{
			this.addEventListener(MouseEvent.CLICK, presentReference);
			glowFilter = new GlowFilter(color, minAlpha, minBlurX, minBlurY, minStrength, 2);
			this.filters = new Array(glowFilter);
			this.increaseHighlighting(null);
		}
			
		private function presentReference (e:MouseEvent)
		{
			var referencePanel:ReferencePanel = new ReferencePanel();
			referencePanel.gotoAndStop(referenceTargetIdentifier);
			stage.addChild(referencePanel);
		}
		
		private function increaseHighlighting (e:TweenEvent)
		{
			var tween:TweenMax = new TweenMax(this, animationSpeed, {glowFilter:{alpha:maxAlpha, strength:maxStrength, blurX:maxBlurX, blurY:maxBlurY}});
			tween.addEventListener(TweenEvent.COMPLETE, decreaseHighlighting);
		}
		
		private function decreaseHighlighting (e:TweenEvent)
		{
			var tween:TweenMax = new TweenMax(this, animationSpeed, {glowFilter:{alpha:minAlpha, strength:minStrength, blurX:minBlurX, blurY:minBlurY}});
			tween.addEventListener(TweenEvent.COMPLETE, increaseHighlighting);
		}
	}
}
