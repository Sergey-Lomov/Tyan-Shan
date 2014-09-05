package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import flashx.textLayout.formats.Float;
	
	public class MembersDosiersMenu extends MovieClip 
	{
		public var membersDosiers:MembersDosiers;

		private var hideNextTween, showNextTween, hidePrevTween, showPrevTween:Tween;
		
		private const dosiersCount:int = 9;
		private const buttonsAnimationSpeed:Number = 0.8;
		
		public function MembersDosiersMenu() 
		{
			prevDosierButton.addEventListener(MouseEvent.CLICK, showPrevDosier);
			nextDosierButton.addEventListener(MouseEvent.CLICK, showNextDosier);
		}
		
		private function showNextDosier (e:Event)
		{
			var currentDosierIndex:int = membersDosiers.currentDosierIndex();
			
			if ((currentDosierIndex + 1) == dosiersCount)
			{
				if (showNextTween != null)
					showNextTween.stop();
				nextDosierButton.removeEventListener(MouseEvent.CLICK, showNextDosier);
				hideNextTween = new Tween(nextDosierButton, "alpha", Strong.easeOut, nextDosierButton.alpha, 0, buttonsAnimationSpeed, true);
				hideNextTween.addEventListener(TweenEvent.MOTION_FINISH, hideNextTweenCompleted);
			}
			
			if (currentDosierIndex == 1)
			{
				if (hidePrevTween != null)
					hidePrevTween.stop();
				prevDosierButton.addEventListener(MouseEvent.CLICK, showPrevDosier);
				showPrevTween = new Tween(prevDosierButton, "alpha", Strong.easeOut, prevDosierButton.alpha, 1, buttonsAnimationSpeed, true);
				showPrevTween.addEventListener(TweenEvent.MOTION_FINISH, showPrevTweenCompleted);
			}
			
			membersDosiers.showNextMemberDosier();
		}
		
		private function showPrevDosier (e:Event)
		{
			var currentDosierIndex:int = membersDosiers.currentDosierIndex();
			
			if (currentDosierIndex == dosiersCount)
			{
				if (hideNextTween != null)
					hideNextTween.stop();
				nextDosierButton.addEventListener(MouseEvent.CLICK, showNextDosier);
				showNextTween = new Tween(nextDosierButton, "alpha", Strong.easeOut, nextDosierButton.alpha, 1, buttonsAnimationSpeed, true);
				showNextTween.addEventListener(TweenEvent.MOTION_FINISH, showNextTweenCompleted);
			}
			
			if (currentDosierIndex == 2)
			{
				if (showPrevTween != null)
					showPrevTween.stop();
				prevDosierButton.removeEventListener(MouseEvent.CLICK, showPrevDosier);
				hidePrevTween = new Tween(prevDosierButton, "alpha", Strong.easeOut, prevDosierButton.alpha, 0, buttonsAnimationSpeed, true);
				hidePrevTween.addEventListener(TweenEvent.MOTION_FINISH, hidePrevTweenCompleted);
			}
			
			membersDosiers.showPrevMemberDosier();
		}
		
		private function showNextTweenCompleted (e:TweenEvent)
		{
			showNextTween = null;
		}
		
		private function hideNextTweenCompleted (e:TweenEvent)
		{
			hideNextTween = null;
		}
		
		private function showPrevTweenCompleted (e:TweenEvent)
		{
			showPrevTween = null;
		}
		
		private function hidePrevTweenCompleted (e:TweenEvent)
		{
			hidePrevTween = null;
		}
	}
}
