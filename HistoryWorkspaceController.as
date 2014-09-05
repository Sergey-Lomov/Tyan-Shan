package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class HistoryWorkspaceController extends MovieClip 
	{
		public function HistoryWorkspaceController () 
		{
			workspaceBottomMenu.membersDosiersButton.addEventListener(MouseEvent.CLICK, handleMembersDosiersClick);
			workspaceBottomMenu.introductionButton.addEventListener(MouseEvent.CLICK, handleIntroductionClick);
		}
		
		private function handleMembersDosiersClick(e:Event)
		{
			this.showMemberDosier("Tretjak");
		}
		
		private function handleIntroductionClick(e:Event)
		{
			this.showIntroduction();
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
			WorkspaceContentController(this.getChildByName("workspaceContent")).showIntroduction();
		}
		
		public function showMemberDosier(dosierName:String)
		{
			workspaceContent.showMemberDosier(dosierName);
		}
	}
}
