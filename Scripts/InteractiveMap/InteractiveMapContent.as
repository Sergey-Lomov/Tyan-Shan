package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.greensock.easing.Power4;

	public class InteractiveMapContent extends MovieClip {

		const startScale:Number = 1;

		const maxZoom:Number = 2.0;
		const minZoom:Number = 0.5;
		const zoomStepMultyplier:Number = 1.25;
		const zoomAnimationSpeed:Number = 0.3;
		const showsAnimationSpeed:Number = 1.5;
		
		public var activated:Boolean = false;
		
		public var mainTrackVisibility, keypointsVisibility, regularPhotosVisibility, premiumPhotosVisibility:Boolean;

		public function InteractiveMapContent() {
			this.addEventListener(MouseEvent.MOUSE_WHEEL, scrollSelf);
			this.addEventListener(MouseEvent.MOUSE_DOWN, startSelfDraging);
			this.addEventListener(MouseEvent.MOUSE_UP, stopSelfDraging);
			
			this.scaleX = this.scaleY = startScale;
			
			mainTrackVisibility = keypointsVisibility = regularPhotosVisibility = premiumPhotosVisibility = true;
			
			interactiveMapStub.alpha = 0;
			mainTrack.alpha = 0;
			mapKeypoints.alpha = 0;
			premiumMapPhotos.alpha = 0;
			regularMapPhotos.alpha = 0;
		}
		
		public function activate() {
			if (!activated)
			{
				activated = true;
				
				TweenMax.killTweensOf(mainTrack);
				TweenMax.killTweensOf(mapKeypoints);
				TweenMax.killTweensOf(premiumMapPhotos);
				TweenMax.killTweensOf(regularMapPhotos);
				
				if (mainTrackVisibility)
					TweenMax.to(mainTrack, showsAnimationSpeed, {alpha : 1});
					
				if (keypointsVisibility)
					TweenMax.to(mapKeypoints, showsAnimationSpeed, {alpha : 1});
					
				if (premiumPhotosVisibility)
					TweenMax.to(premiumMapPhotos, showsAnimationSpeed, {alpha : 1});
				
				if (regularPhotosVisibility)
					TweenMax.to(regularMapPhotos, showsAnimationSpeed, {alpha : 1});
			}
		}
		
		public function deactivate() {
			if (activated)
			{
				activated = false;
				TweenMax.killTweensOf(mainTrack);
				TweenMax.killTweensOf(mapKeypoints);
				TweenMax.killTweensOf(premiumMapPhotos);
				TweenMax.killTweensOf(regularMapPhotos);
				TweenMax.to(mainTrack, showsAnimationSpeed, {alpha : 0});
				TweenMax.to(mapKeypoints, showsAnimationSpeed, {alpha : 0});
				TweenMax.to(premiumMapPhotos, showsAnimationSpeed, {alpha : 0});
				TweenMax.to(regularMapPhotos, showsAnimationSpeed, {alpha : 0});
			}
		}

		private function scrollSelf (e:MouseEvent) {
			if (activated)
			{
				var planZoom:Number;
				
				if (e.delta > 0)
					planZoom = this.scaleX * zoomStepMultyplier;
				else
					planZoom = this.scaleX / zoomStepMultyplier;
					
				if (planZoom < minZoom)
					planZoom = minZoom;
				
				if (planZoom > maxZoom)
					planZoom = maxZoom;
					
				this.zoom(planZoom);
			}
		}
		
		public function restoreZoom () {
			this.zoom(1.0, false);
		}
		
		private function zoom(zoom:Number, useMousePosition:Boolean = true) {
			var scaleRatioX = zoom / this.scaleX;
			var scaleRatioY = zoom / this.scaleY;
			var newX, newY:Number 
			
			if (useMousePosition) {
				newX = parent.mouseX - (parent.mouseX - x) * scaleRatioX;
				newY = parent.mouseY - (parent.mouseY - y) * scaleRatioY;
			}
			else {
				var center:Point = new Point(stage.stageWidth / 2 - parent.x, stage.stageHeight / 2 - parent.y);
				newX = center.x - (center.x - x) * scaleRatioX;
				newY = center.y - (center.y - y) * scaleRatioY;
			}
			
			var bx:Number = stage.fullScreenWidth - width * scaleRatioX - parent.x;
			var by:Number = stage.fullScreenHeight - height * scaleRatioY- parent.y;
			var bounds:Rectangle = new Rectangle(bx, by, - parent.x - bx, - parent.y - by);
			
			if (newX > bounds.right)
				newX = bounds.right;
			
			if (newX < bounds.left)
				newX = bounds.left;
				
			if (newY > bounds.bottom)
				newY = bounds.bottom;
			
			if (newY < bounds.top)
				newY = bounds.top;
				
				
			TweenMax.killTweensOf(this);
			TweenMax.to(this, zoomAnimationSpeed, {scaleX : zoom, scaleY : zoom, x : newX, y : newY});
			
			var unzoomableClips:Array = ObjectsStore.shareStore.unzoomableClips;
			for (var i:int = 0; i < unzoomableClips.length; i++) {
				TweenMax.killTweensOf(unzoomableClips[i]);
				TweenMax.to(unzoomableClips[i], zoomAnimationSpeed, {scaleX : unzoomableClips[i].scaleX * 1/scaleRatioX,
																	scaleY : unzoomableClips[i].scaleY * 1/scaleRatioY});
			}
		}
		
		private function startSelfDraging (e:MouseEvent) {
			if (activated) {
				var bx:Number = stage.fullScreenWidth - width - parent.x;
				var by:Number = stage.fullScreenHeight - height - parent.y;
				var bounds:Rectangle = new Rectangle(bx, by, - parent.x - bx, - parent.y - by);
				this.startDrag(false, bounds);
			}
		}
		
		private function stopSelfDraging (e:MouseEvent) {
			if (activated)
				this.stopDrag();
		}
		
		public function setMainTrackVisibility (visibility:Boolean) {
			if (mainTrackVisibility != visibility) {
				mainTrackVisibility = visibility;
				TweenMax.killTweensOf(mainTrack);
				
				if (mainTrackVisibility)
					TweenMax.to(mainTrack, showsAnimationSpeed, {alpha : 1});
				else
					TweenMax.to(mainTrack, showsAnimationSpeed, {alpha : 0});
			}
		}
		
		public function setRegularPhotosVisibility (visibility:Boolean) {
			if (regularPhotosVisibility != visibility) {
				regularPhotosVisibility = visibility;
				TweenMax.killTweensOf(regularMapPhotos);
				
				if (regularPhotosVisibility)
					TweenMax.to(regularMapPhotos, showsAnimationSpeed, {alpha : 1});
				else
					TweenMax.to(regularMapPhotos, showsAnimationSpeed, {alpha : 0});
			}
		}
		
		public function setKeypointsVisibility (visibility:Boolean) {
			if (keypointsVisibility != visibility) {
				keypointsVisibility = visibility;
				TweenMax.killTweensOf(mapKeypoints);
				
				if (keypointsVisibility)
					TweenMax.to(mapKeypoints, showsAnimationSpeed, {alpha : 1});
				else
					TweenMax.to(mapKeypoints, showsAnimationSpeed, {alpha : 0});
			}
		}

	}
}
