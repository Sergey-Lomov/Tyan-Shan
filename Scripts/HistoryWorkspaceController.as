package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.greensock.*;
	import flash.display.Stage;

	public class HistoryWorkspaceController extends MovieClip 
	{
		public static var sharedHistoryWorkspace:HistoryWorkspaceController = null;
		
		private const mapShowingDuration:Number = 1.0;
		private var globalStage:Stage;
		
		public function HistoryWorkspaceController () 
		{
			if (sharedHistoryWorkspace == null)
				sharedHistoryWorkspace = this;
			
			workspaceBottomMenu.workspaceContent = workspaceContent;
			workspaceContent.workspaceBottomMenu = workspaceBottomMenu;
			workspaceContent.historyWorkspace = this;
		}

		public function showMap ()
		{
			InteractiveMap.sharedMap.activate();
			globalStage = stage;
			var finishY:Number = -(this.height * this.scaleY);
			TweenMax.to(this, mapShowingDuration, {y : finishY, onCompleteParams:[this], onComplete:
							function (self:HistoryWorkspaceController):void
							{
								self.parent.removeChild(self);
							}});
		}
		
		public function presentSelf ()
		{
			globalStage.addChild(this);
			this.y = -(this.height * this.scaleY);
			TweenMax.to(this, mapShowingDuration, {y : stage.stageHeight / 2});
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
