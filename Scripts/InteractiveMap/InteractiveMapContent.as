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
		const zoomStepMultyplier:Number = 1.5;
		const zoomAnimationSpeed:Number = 0.6;
		const showsAnimationSpeed:Number = 0.6;
		
		public var activated:Boolean = false;

		public function InteractiveMapContent() {
			this.addEventListener(MouseEvent.MOUSE_WHEEL, scrollSelf);
			this.addEventListener(MouseEvent.MIDDLE_CLICK, restoreZoom);
			this.addEventListener(MouseEvent.MOUSE_DOWN, startSelfDraging);
			this.addEventListener(MouseEvent.MOUSE_UP, stopSelfDraging);
			
			this.scaleX = this.scaleY = startScale;
			
			interactiveMapStub.alpha = 0;
			mainTrack.alpha = 0;
		}
		
		public function activate() {
			if (!activated)
			{
				activated = true;
				TweenMax.to(mainTrack, showsAnimationSpeed, {alpha : 1});
			}
		}
		
		public function deactivate() {
			if (activated)
			{
				activated = false;
				TweenMax.to(mainTrack, showsAnimationSpeed, {alpha : 0});
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
		
		private function restoreZoom(e:MouseEvent) {
			if (activated)
				this.zoom(1);
		}
		
		private function zoom(zoom:Number) {
			var scaleRatioX = zoom / this.scaleX;
			var scaleRatioY = zoom / this.scaleY;
			var newX:Number = parent.mouseX - (parent.mouseX - x) * scaleRatioX; /*((parent.x + x - stage.mouseX) * scaleRatioX) + stage.mouseX - parent.x;*/
			var newY:Number = parent.mouseY - (parent.mouseY - y) * scaleRatioY;/*((parent.y + y - stage.mouseY) * scaleRatioY) + stage.mouseY - parent.y;*/
			
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
	}
}
