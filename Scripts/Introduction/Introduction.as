package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Introduction extends MovieClip
	{		
		public var workspaceContent:WorkspaceContentController;
	
		public function Introduction() 
		{
			membersDosiersLink.addEventListener(MouseEvent.CLICK, showMemebersDosiers);
			adventureLink.addEventListener(MouseEvent.CLICK, showAdventure);
		}
		
		private function showMemebersDosiers(e:MouseEvent)
		{
			workspaceContent.showMembersDosiers();
		}
		
		private function showAdventure(e:MouseEvent)
		{
			workspaceContent.showAdventure();
		}
	}
	
}
