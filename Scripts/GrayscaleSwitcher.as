package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import com.greensock.*;
	import com.greensock.easing.Linear;
	
	public class GrayscaleSwitcher extends MovieClip{

		private var switcher:MovieClip;
		//protected var disabledColor:Color = new Color(0.4, 0.4, 0.4, 1.0);
		protected const stateChangingDuration:Number = 1.0;
		
		//private var defaultColor:uint;
		private var switcherTween:TweenMax = null;
		
		public var active:Boolean = true;

		public function GrayscaleSwitcher() {
			switcher = MovieClip(this.getChildByName("switcherClip"));
			//defaultColor = switcher.transform.colorTransform.color;
			switcherTween = new TweenMax(switcher,stateChangingDuration, {frame:switcher.totalFrames, ease:Linear.easeNone});
			switcherTween.pause();
			
			this.addEventListener(MouseEvent.CLICK, switchSelf);
		}
		
		public function setActive (_active:Boolean, animated:Boolean = true) {
			active = _active;
			this.updateSwitcher(animated);
		}
		
		protected function switchSelf (e:MouseEvent) {
			active = !active;
			this.updateSwitcher();
		}
		
		protected function updateSwitcher (animated:Boolean = true) {
			if (active)
				if (animated)
					switcherTween.reverse();
				else
					switcherTween.totalProgress(0);
			else
				if (animated)
					switcherTween.play();
				else
					switcherTween.totalProgress(1);
			/*var color:uint = defaultColor;
			
			if (!active)
				color = disabledColor.redMultiplier  << 16 | disabledColor.greenMultiplier  << 8 | disabledColor.blueMultiplier;
				
			TweenMax.to(switcher, stateChangingDuration, {colorTransform: {color : color}});*/
		}
	}
}
