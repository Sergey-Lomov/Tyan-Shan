package {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Introduction extends MovieClip	{		
		public var workspaceContent:WorkspaceContentController;
	
		public function Introduction() {
			membersDosiersLink.addEventListener(MouseEvent.CLICK, showMemebersDosiers);
			adventureLink.addEventListener(MouseEvent.CLICK, showAdventure);
			mapLink.addEventListener(MouseEvent.CLICK, showMap);
			conclusionsLink.addEventListener(MouseEvent.CLICK, showConclusions);
		}
		
		private function showMemebersDosiers(e:MouseEvent) {
			workspaceContent.showMembersDosiers();
		}
		
		private function showAdventure(e:MouseEvent) {
			workspaceContent.showAdventure();
		}
		
		private function showMap(e:MouseEvent) {
			workspaceContent.showMap();
		}
		
		private function showConclusions (e:MouseEvent)
		{
			workspaceContent.showConclusions();
		}
	}
	
}
