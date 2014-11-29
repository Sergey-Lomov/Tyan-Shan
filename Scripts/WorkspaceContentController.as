package  
{
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class WorkspaceContentController extends MovieClip 
	{
		public var historyWorkspace:HistoryWorkspaceController;
		
		public var workspaceBottomMenu:WorkspaceBottomMenuController;
		
		private var currentSection:MovieClip;
		private var sectionsNames:Array = new Array();
		
		public function WorkspaceContentController ()
		{
			sectionsNames.push("contentPage", "introduction", "membersDosiers", "adventure", "conclusions");
			this.gotoAndStop("Introduction");
			currentSection = introduction;
			introduction.workspaceContent = this;
		}
		
		public function showIntroduction() 
		{
			this.gotoAndStop("Introduction");
			currentSection = introduction;
			introduction.workspaceContent = this;
			this.updateButtons();
		}
		
		public function showMembersDosiers()
		{
			showMemberDosier("Tretjak");
		}
		
		public function showMemberDosier(dosierName:String) 
		{
			this.gotoAndStop("Dosiers");
			currentSection = membersDosiers;
			membersDosiers.gotoAndStop(dosierName);
			this.updateButtons();
		}
		
		public function showAdventure() 
		{
			showAdventureAtFrame("Content");
		}
		
		public function showAdventureAtFrame(frameName:String) 
		{
			this.gotoAndStop("Adventure");
			currentSection = adventure;
			adventure.gotoAndStop(frameName);
			this.updateButtons();
		}
		
		public function showConclusions ()
		{
			this.gotoAndStop("Conclusions");
			currentSection = conclusions;
			conclusions.gotoAndStop(1);
			this.updateButtons();
		}
		
		public function showSettingsPage ()
		{
			
		}
		
		public function showContentPage ()
		{
			this.gotoAndStop("Content");
			currentSection = contentPage;
			contentPage.workspaceContent = this;
			this.updateButtons();
		}
		
		public function showMap ()
		{
			historyWorkspace.showMap();
		}
		
		public function showNextPage()
		{
			if (currentSection.currentFrame < currentSection.totalFrames)
				currentSection.nextFrame();
			else
			{
				if (this.currentFrame < this.totalFrames)
				{
					this.nextFrame();
					initCurrentSection();
					currentSection = this.getChildByName(sectionsNames[currentFrame - 1]) as MovieClip;
					currentSection.gotoAndStop(1);
				}
			}
			
			this.updateButtons();
		}
		
		public function showPrevPage()
		{			
			if (currentSection.currentFrame > 1)
				currentSection.prevFrame();
			else
			{
				if (this.currentFrame > 1)
				{
					this.prevFrame();
					initCurrentSection();
					currentSection = this.getChildByName(sectionsNames[currentFrame - 1]) as MovieClip;
					currentSection.gotoAndStop(currentSection.totalFrames);
				}
			}

			this.updateButtons();
		}
		
		public function updateButtons ()
		{
			if (currentFrame == 1 && currentSection.currentFrame == 1)
				workspaceBottomMenu.hidePrevPageButton();
			else
				workspaceBottomMenu.showPrevPageButton();
			
			if (currentFrame == totalFrames && currentSection.currentFrame == currentSection.totalFrames)
				workspaceBottomMenu.hideNextPageButton();
			else
				workspaceBottomMenu.showNextPageButton();
		}
		
		public function initCurrentSection ()
		{
			if (sectionsNames[currentFrame - 1] == "introduction")
			{
				var introductionSection:MovieClip = this.getChildByName(sectionsNames[currentFrame - 1]) as Introduction;
				introductionSection.workspaceContent = this;
			}
			else if (sectionsNames[currentFrame - 1] == "contentPage")
			{
				var contentSection:MovieClip = this.getChildByName(sectionsNames[currentFrame - 1]) as HistoryContent;
				contentSection.workspaceContent = this;
			}
		}
	}
}
