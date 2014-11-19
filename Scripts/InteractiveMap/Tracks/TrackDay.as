package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import fl.motion.Color;
	import com.greensock.*;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	
	public class TrackDay extends MovieClip {

		protected var hint:MovieClip;
		protected var defaultColor:Color;
		protected var highlightedColor:Color;
		protected var stateChangingDuration:Number = 1.0;

		private var active:Boolean = false;

		public function TrackDay() {
			this.addEventListener(MouseEvent.CLICK, changeState);
		}
		
		private function changeState (e:MouseEvent) {
			active = !active;
			this.updateState(true);
		}
		
		protected function updateState (animated:Boolean) {
			var colorTransform:ColorTransform = new ColorTransform();
			var color:uint = defaultColor.redMultiplier  << 16 | defaultColor.greenMultiplier  << 8 | defaultColor.blueMultiplier;
			
			if (active)
				color = highlightedColor.redMultiplier  << 16 | highlightedColor.greenMultiplier  << 8 | highlightedColor.blueMultiplier;
			
			for (var i:int = 0; i < this.numChildren; i++) {
				var children:DisplayObject = this.getChildAt(i);
				if (children is Shape) {
					var shape:Shape = Shape(children);
					TweenMax.killTweensOf(shape);
					TweenMax.to(shape, stateChangingDuration, {colorTransform: {color : color}});
				}
			}
			
			if (hint != null) {
				TweenMax.killTweensOf(hint);
				
				if (active) {
					if (hint.parent == null)
						this.addChild(hint);
					TweenMax.to(hint, stateChangingDuration, {alpha : 1});
				}
				else
					TweenMax.to(hint, stateChangingDuration, {alpha : 0, onCompleteParams:[this], onComplete:
					function (self:TrackDay):void
					{
						self.removeChild(hint);
					}});;
			}
		}
	}
}
