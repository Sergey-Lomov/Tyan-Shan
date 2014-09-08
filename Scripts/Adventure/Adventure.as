package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.greensock.TweenMax;
		
	public class Adventure extends MovieClip
	{			
		private const buttonsAnimationSpeed = 0.8;
	
		public function Adventure()
		{
			nextPageButton.alpha = 0;
			adventureContent.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		public function showAdventureAtFrame (frameName:String) 
		{
			adventureContent.gotoAndStop(frameName);
		}
		
		private function showNextPage (e:MouseEvent)
		{
			this.nextFrame();
		}
		
		private function handleEnterFrame (e:Event)
		{
			if ((adventureContent.currentFrame > 1)
				&& (adventureContent.currentFrame < adventureContent.totalFrames))
			{
				nextPageButton.addEventListener(MouseEvent.CLICK, showNextPage);
				TweenMax.to(nextPageButton, buttonsAnimationSpeed, {alpha:1});
			}
			else
			{
				nextPageButton.removeEventListener(MouseEvent.CLICK, showNextPage);
				TweenMax.to(nextPageButton, buttonsAnimationSpeed, {alpha:0});
			}
		}
	}
}
