package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	
	public class MapSettings extends MovieClip {
		
		private static var instance:MapSettings;
		
		private const animationDuration:Number = 0.7;
		private const fullWidth:Number = 800;
		private const fullHeight:Number = 600;
		
		public function MapSettings() {
			if (stage != null)
			{
				setupToStage(null);
			}
			else
			{
				this.addEventListener(Event.ADDED_TO_STAGE, setupToStage);
			}
			
			closeSettingsButton.addEventListener(MouseEvent.CLICK, closeSelf);
			this.removeChild(fogging);
		}
		
		public static function sharedMapSettings () {
			if (instance == null)
				instance = new MapSettings();
			
			return instance;
		}
		
		private function setupToStage (e:Event)
		{
			this.x = stage.stageWidth / 2;
			this.y = stage.stageHeight / 2;
			this.width = 0;
			this.height = 0;

			stage.addChild(fogging);
			stage.setChildIndex(fogging, stage.numChildren - 2);
			fogging.x = fogging.y = 0;
			fogging.width = stage.stageWidth;
			fogging.height = stage.stageHeight;
			fogging.alpha = 0;
			
			TweenMax.to(fogging, animationDuration, {alpha : 1});
			TweenMax.to(this, animationDuration, {width : fullWidth});
			TweenMax.to(this, animationDuration, {height : fullHeight});
		}
		
		public function closeSelf (e:MouseEvent)
		{
			TweenMax.killTweensOf(this);
			
			TweenMax.to(this, animationDuration, {width : 0});
			TweenMax.to(this, animationDuration, {height : 0, onCompleteParams:[this], onComplete:
				function (self:MapSettings):void
				{
					self.parent.removeChild(self);
				}});
			TweenMax.to(fogging, animationDuration, {alpha : 0, onCompleteParams:[fogging], onComplete:
				function (fogging:MovieClip):void
				{
					fogging.parent.removeChild(fogging);
				}});
		}
		
		public function setMainTrackVisibility (visibility:Boolean) {
			mainTrackSwitcher.setActive(visibility, false);
		}
		
		public function setRegularPhotosVisibility (visibility:Boolean) {
			regularPhotosSwitcher.setActive(visibility, false);
		}
		
		public function setKeypointsVisibility (visibility:Boolean) {
			keypointSwitcher.setActive(visibility, false);
		}
	}
}
