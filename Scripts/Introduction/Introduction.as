package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Introduction extends MovieClip
	{		
		public var workspaceContentController:WorkspaceContentController;
	
		public function Introduction() 
		{
			membersDosiersLink.addEventListener(MouseEvent.CLICK, showMemebersDosiers);
			adventureLink.addEventListener(MouseEvent.CLICK, showAdventure);
		}
		
		private function showMemebersDosiers(e:MouseEvent)
		{
			workspaceContentController.showMemberDosier("Tretjak");
		}
		
		private function showAdventure(e:MouseEvent)
		{
			workspaceContentController.showAdventureAtFrame("Content");
		}
	}
	
}
