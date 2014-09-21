package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class HistoryWorkspaceController extends MovieClip 
	{
		public function HistoryWorkspaceController () 
		{
			workspaceBottomMenu.workspaceContent = workspaceContent;
			workspaceContent.workspaceBottomMenu = workspaceBottomMenu;
		}

		private function hideSelf() 
		{
			this.visible = false;
		}
		
		public function showSelf() 
		{
			this.visible = true;
		}
		
		public function showIntroduction() 
		{
			workspaceContent.showIntroduction();
		}
		
		public function showMemberDosier(dosierName:String)
		{
			workspaceContent.showMemberDosier(dosierName);
		}
		
	/*	public function handleEnteringLastPage
		{
			workspaceBottomMenu.hideNextPageButton();
		}
		
		public function handleLeavingLastPage
		{
			workspaceBottomMenu.showPrevPageButton();
		}
		
		public function handleEnteringFirstPage
		{
			workspaceBottomMenu.hidePrevPageButton();
		}
		
		public function handleLeavingFirstPage
		{
			workspaceBottomMenu.showNextPageButton():
		}*/
	}
}
