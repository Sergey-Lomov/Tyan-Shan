package  
{
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class WorkspaceContentController extends MovieClip 
	{
		public function WorkspaceContentController ()
		{
			introduction.workspaceContentController = this;
		}
		
		public function showIntroduction() 
		{
			this.gotoAndStop("Introduction");
			introduction.workspaceContentController = this;
		}
		
		public function showMemberDosier(dosierName:String) 
		{
			this.gotoAndStop("Dosiers");
			membersDosiers.showMemberDosier(dosierName);
		}
		
		public function showAdventureAtFrame(frameName:String) 
		{
			this.gotoAndStop("Adventure");
			adventure.gotoAndStop(frameName);
		}
	}
	
}
