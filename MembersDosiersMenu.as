package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import flashx.textLayout.formats.Float;
	import com.greensock.TweenMax;
	
	public class MembersDosiersMenu extends MovieClip 
	{
		public var membersDosiers:MembersDosiers;
		
		private const dosiersCount:int = 9;
		private const buttonsAnimationSpeed:Number = 0.8;
		
		public function MembersDosiersMenu() 
		{
			prevDosierButton.alpha = 0;
			prevDosierButton.addEventListener(MouseEvent.CLICK, showPrevDosier);
			nextDosierButton.addEventListener(MouseEvent.CLICK, showNextDosier);
		}
		
		private function showNextDosier (e:Event)
		{
			var currentDosierIndex:int = membersDosiers.currentFrame;
			
			if ((currentDosierIndex + 1) == dosiersCount)
			{
				TweenMax.to(nextDosierButton, buttonsAnimationSpeed, {alpha:0});
			}
			
			if (currentDosierIndex == 1)
			{
				TweenMax.to(prevDosierButton, buttonsAnimationSpeed, {alpha:1});
			}
			
			membersDosiers.nextFrame();
		}
		
		private function showPrevDosier (e:Event)
		{
			var currentDosierIndex:int = membersDosiers.currentFrame;
			
			if (currentDosierIndex == dosiersCount)
			{
				TweenMax.to(nextDosierButton, buttonsAnimationSpeed, {alpha:1});
			}
			
			if (currentDosierIndex == 2)
			{
				TweenMax.to(prevDosierButton, buttonsAnimationSpeed, {alpha:0});
			}
			
			membersDosiers.prevFrame();
		}
	}
}
