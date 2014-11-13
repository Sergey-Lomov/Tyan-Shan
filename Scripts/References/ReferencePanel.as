package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;	
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import flash.events.MouseEvent;
	
	public class ReferencePanel extends MovieClip {
		
		
		public function ReferencePanel()
		{
			if (stage != null)
			{
				setupToStage(null);
			}
			else
			{
				this.addEventListener(Event.ADDED_TO_STAGE, setupToStage);
			}
			
			closeReferenceButton.addEventListener(MouseEvent.CLICK, closeSelf);
		}
	
		private function setupToStage (e:Event)
		{
			this.x = stage.stageWidth / 2;
			this.y = stage.stageHeight / 2;

			var scaleXTween:Tween = new Tween(this, "scaleX", Strong.easeOut, 0, this.scaleX, 1, true);
			var scaleYTween:Tween = new Tween(this, "scaleY", Strong.easeOut, 0, this.scaleY, 1, true);
		}
		
		public function closeSelf (e:Event)
		{
			var scaleXTween:Tween = new Tween(this, "scaleX", Strong.easeOut, this.scaleX, 0, 1, true);
			var scaleYTween:Tween = new Tween(this, "scaleY", Strong.easeOut, this.scaleY, 0, 1, true);
			
			scaleYTween.addEventListener(TweenEvent.MOTION_FINISH, removeSelfFromParent);
		}
		
		private function removeSelfFromParent (e:Event)
		{
			this.parent.removeChild(this);
		}
	}
}
