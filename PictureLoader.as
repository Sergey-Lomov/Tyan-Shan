package 
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.geom.Matrix;

	public class PictureLoader extends MovieClip
	{

		var loader:Loader = new Loader();

		public function PictureLoader()
		{
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
		}

		public function loadFromUrl(url:String)
		{
			var fileRequest:URLRequest = new URLRequest(url);
			loader.load(fileRequest);
		}
		
		public function onLoaderProgress(e:ProgressEvent)
		{
			// this is where progress will be monitored     
			trace(e.bytesLoaded, e.bytesTotal);
		}

		public function onLoaderComplete(e:Event)
		{
			var tm:Matrix = new Matrix();
			tm.translate(-loader.width / 2, -loader.height / 2);
			loader.transform.matrix = tm;

			addChild(loader);
		}
	}

}