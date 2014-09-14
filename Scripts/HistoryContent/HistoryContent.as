package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class HistoryContent extends MovieClip 
	{
		public var workspaceContent:WorkspaceContentController;
		
		public function HistoryContent()
		{
			introductionLink.addEventListener(MouseEvent.CLICK, showIntroduction);
			dosiersLink.addEventListener(MouseEvent.CLICK, showDosiers);
			adventureLink.addEventListener(MouseEvent.CLICK, showAdventure);
			mapLink.addEventListener(MouseEvent.CLICK, showMap);
			conclusionsLink.addEventListener(MouseEvent.CLICK, showConclusions);
		}
		
		private function showIntroduction (e:MouseEvent)
		{
			workspaceContent.showIntroduction();
		}
		
		private function showDosiers (e:MouseEvent)
		{
			workspaceContent.showMembersDosiers();
		}
		
		private function showAdventure (e:MouseEvent)
		{
			workspaceContent.showAdventure();
		}
		
		private function showMap (e:MouseEvent)
		{
			workspaceContent.showMap();
		}
		
		private function showConclusions (e:MouseEvent)
		{
			workspaceContent.showConclusions();
		}
	}
}
