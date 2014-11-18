package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.greensock.TweenMax;
	
	public class WorkspaceBottomMenuController extends MovieClip 
	{
		public var workspaceContent:WorkspaceContentController;
		
		private const buttonsAnimationSpeed:Number = 0.8;

		public function WorkspaceBottomMenuController() 
		{
			prevPageButton.addEventListener(MouseEvent.CLICK, showPrevPage);
			nextPageButton.addEventListener(MouseEvent.CLICK, showNextPage);
			settingsButton.addEventListener(MouseEvent.CLICK, showSettings);
			contentButton.addEventListener(MouseEvent.CLICK, showContent);
		}

		public function hideNextPageButton ()
		{
			//TweenMax.killTweensOf(nextPageButton);
			TweenMax.to(nextPageButton, buttonsAnimationSpeed, {alpha : 0});
		}
		
		public function hidePrevPageButton ()
		{
			//TweenMax.killTweensOf(prevPageButton);
			TweenMax.to(prevPageButton, buttonsAnimationSpeed, {alpha : 0});
		}

		public function showNextPageButton ()
		{
			//TweenMax.killTweensOf(nextPageButton);
			TweenMax.to(nextPageButton, buttonsAnimationSpeed, {alpha : 1});
		}
		
		public function showPrevPageButton ()
		{
			//TweenMax.killTweensOf(prevPageButton);
			TweenMax.to(prevPageButton, buttonsAnimationSpeed, {alpha : 1});
		}

		private function showPrevPage(e:MouseEvent)
		{
			workspaceContent.showPrevPage();
		}
		
		private function showNextPage(e:MouseEvent)
		{
			workspaceContent.showNextPage();
		}
		
		private function showSettings(e:MouseEvent)
		{
			workspaceContent.showSettingsPage();
		}
		
		private function showContent(e:MouseEvent)
		{
			workspaceContent.showContentPage();
		}
	}
}
