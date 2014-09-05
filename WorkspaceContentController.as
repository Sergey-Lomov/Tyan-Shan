package  
{
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class WorkspaceContentController extends MovieClip 
	{
		public function showIntroduction() 
		{
			this.gotoAndStop(1);
		}
		
		public function showMemberDosier(dosierName:String) 
		{
			this.gotoAndStop("Dosiers");
			membersDosiers.showMemberDosier(dosierName);
		}

	}
	
}
