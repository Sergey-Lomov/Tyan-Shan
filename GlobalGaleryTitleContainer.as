package  {
	
	import flash.display.MovieClip;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	
	
	public class GlobalGaleryTitleContainer extends MovieClip {
		
		const textAnimationSpeed:Number = 2;
		
		var textAnimation:Tween = null;
		var isTextVisible:Boolean = true;
		
		public function GlobalGaleryTitleContainer() {
			this.addEventListener(MouseEvent.CLICK, handleMouseClick);
		}
		
		public function setText (text:String)
		{
			titleField.text = text;
			titleField.autoSize = TextFieldAutoSize.CENTER;
			titleField.y = -titleField.height - 10;
		}
		
		private function handleMouseClick(e:Event)
		{
			if (textAnimation != null)
				textAnimation.stop();
			
			if (isTextVisible)
			{
				textAnimation = new Tween(titleField, "alpha", Strong.easeOut, titleField.alpha, 0, textAnimationSpeed, true);
				textAnimation.addEventListener(TweenEvent.MOTION_FINISH, clearTextAnimation);
				isTextVisible = false;
			}
			else
			{
				textAnimation = new Tween(titleField, "alpha", Strong.easeOut, titleField.alpha, 1, textAnimationSpeed, true);
				textAnimation.addEventListener(TweenEvent.MOTION_FINISH, clearTextAnimation);
				isTextVisible = true;
			}
		}
		
		private function clearTextAnimation(e:Event)
		{
			textAnimation = null;
		}
	}
	
}
