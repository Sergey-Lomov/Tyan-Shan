package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.greensock.*;

	public class HistoryWorkspaceController extends MovieClip 
	{
		const mapShowingDuration:Number = 1.0;
		
		public function HistoryWorkspaceController () 
		{
			workspaceBottomMenu.workspaceContent = workspaceContent;
			workspaceContent.workspaceBottomMenu = workspaceBottomMenu;
			workspaceContent.historyWorkspace = this;
		}

		public function showMap ()
		{
			var finishY:Number = -(this.height * this.scaleY);
			TweenMax.to(this, mapShowingDuration, {y : finishY, onCompleteParams:[this], onComplete:
							function (self:HistoryWorkspaceController):void
							{
								self.parent.removeChild(self);
								InteractiveMap.sharedMap.activate();
							}});
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
	}
}
