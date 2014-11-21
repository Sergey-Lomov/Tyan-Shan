package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.greensock.easing.Power4;

	public class InteractiveMap extends MovieClip {
				
		public static var sharedMap:InteractiveMap;
		
		const startScale:Number = 1;
		const startXDisplacement:Number = -50;
		const startYDisplacement:Number = 100;
		const maxZoom:Number = 2.0;
		const minZoom:Number = 0.5;
		const zoomStepMultyplier:Number = 1.5;
		const zoomAnimationSpeed:Number = 0.6;
		
		public var isActive:Boolean;
				
		public function InteractiveMap() {
			this.addEventListener(MouseEvent.MOUSE_WHEEL, scrollSelf);
			this.addEventListener(MouseEvent.MIDDLE_CLICK, restoreZoom);
			this.addEventListener(MouseEvent.MOUSE_DOWN, startSelfDraging);
			this.addEventListener(MouseEvent.MOUSE_UP, stopSelfDraging);
			
			this.scaleX = this.scaleY = startScale;
			this.x += startXDisplacement;
			this.y += startYDisplacement;
			
			interactiveMapStub.alpha = 0;
		}
		
		private function scrollSelf (e:MouseEvent) {
			if (isActive)
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
			if (isActive)
				this.zoom(1);
		}
		
		private function zoom(zoom:Number) {
			var scaleRatioX = zoom / this.scaleX;
			var scaleRatioY = zoom / this.scaleY;
			var newX:Number = stage.mouseX + (this.x - stage.mouseX) * scaleRatioX;
			var newY:Number = stage.mouseY + (this.y - stage.mouseY) * scaleRatioY;
			
			if (newX > 0)
				newX = 0;
			
			if (newX + this.width * scaleRatioX < stage.stageWidth)
				newX = stage.stageWidth - this.width * scaleRatioX;
				
			if (newY > 0)
				newY = 0;
			
			if (newY + this.height * scaleRatioY < stage.stageHeight)
				newY = stage.stageHeight - this.height * scaleRatioY;
				
				
			TweenMax.killTweensOf(this);
			TweenMax.to(this, zoomAnimationSpeed, {scaleX : zoom, scaleY : zoom, x : newX, y : newY});
		}
		
		private function startSelfDraging (e:MouseEvent) {
			var bounds:Rectangle = new Rectangle(
                        stage.stageWidth - this.width, 
                        stage.stageHeight - this.height, 
                        this.width - stage.stageWidth, 
                        this.height - stage.stageHeight);
			this.startDrag(false, bounds);
		}
		
		private function stopSelfDraging (e:MouseEvent) {
			this.stopDrag();
		}
	}
}
