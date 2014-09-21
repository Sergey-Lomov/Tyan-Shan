﻿package  
{
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class WorkspaceContentController extends MovieClip 
	{
		public var workspaceBottomMenu:WorkspaceBottomMenuController;
		
		private var currentSection:MovieClip;
		private var sectionsNames:Array = new Array();
		
		public function WorkspaceContentController ()
		{
			sectionsNames.push("introduction", "contentPage", "membersDosiers", "adventure");
			currentSection = introduction;
			introduction.workspaceContent = this;
		}
		
		public function showIntroduction() 
		{
			this.gotoAndStop("Introduction");
			currentSection = introduction;
			introduction.workspaceContent = this;
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
		}
		
		public function showConclusions ()
		{
			
		}
		
		public function showSettingsPage ()
		{
			
		}
		
		public function showContentPage ()
		{
			this.gotoAndStop("Content");
			currentSection = contentPage;
			contentPage.workspaceContent = this;
		}
		
		public function showMap ()
		{
			
		}
		
		public function showNextPage()
		{
			if (currentFrame == 1 && currentSection.framesLoaded == 1)
				workspaceBottomMenu.showPrevPageButton();
			
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
			
			if (currentFrame == totalFrames && currentSection.currentFrame == currentSection.totalFrames)
				workspaceBottomMenu.hideNextPageButton();
		}
		
		public function showPrevPage()
		{
			if (currentFrame == totalFrames && currentSection.currentFrame == currentSection.totalFrames)
				workspaceBottomMenu.showNextPageButton();
			
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
			
			if (this.currentFrame == 1 && currentSection.currentFrame == 1)
				workspaceBottomMenu.hidePrevPageButton();
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