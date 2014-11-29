package  {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import com.greensock.*;
	import com.greensock.easing.Linear;
	import flash.geom.Point;
	
	public class MapPhoto extends MovieClip {

		protected var tracerPresentationSpeed:Number = 0.5;
		protected var tracer:MovieClip;
		protected var main:MovieClip;
		protected var photosDirectory:String;
		
		private var tracerTween:TweenMax = null;

		public function MapPhoto() {
			ObjectsStore.shareStore.unzoomableClips.push(this);
			
			main = MovieClip(this.getChildByName("mainClip"));
			main.addEventListener(MouseEvent.MOUSE_OVER, showTracer);
			main.addEventListener(MouseEvent.MOUSE_OUT, hideTracer);
			main.addEventListener(MouseEvent.CLICK, showPhoto);
			
			tracer = MovieClip(this.getChildByName("tracerClip"));
			tracer.gotoAndStop(0);
			tracerTween = new TweenMax(tracer,tracerPresentationSpeed, {frame:tracer.totalFrames, ease:Linear.easeNone,
									   onCompleteParams:[this], onComplete:
							function (self:MapPhoto):void
							{
								var mousePoint:Point = self.main.localToGlobal(new Point(self.mouseX,self.mouseY));
								if (!self.main.hitTestPoint(mousePoint.x,mousePoint.y,true))
									tracerTween.reverse();
							}});
		}
		
		private function showPhoto(e:MouseEvent) {
			var globalGalery:GlobalGalery = new GlobalGalery();
			globalGalery.picturesPaths = [photosDirectory + this.name + ".jpg"];
			globalGalery.picturesTitles = [""];
			stage.addChild(globalGalery);
			
			this.hideTracer(null);
		}
		
		private function showTracer (e:MouseEvent) {
			tracerTween.play();
		}
		
		private function hideTracer (e:MouseEvent) {
			if (tracerTween.progress() === 1)
				tracerTween.reverse();
		}
	}
}
