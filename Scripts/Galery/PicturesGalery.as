package  {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Shape;
	import flash.utils.ByteArray;
	import flash.display.Loader;
	import flash.filesystem.*;
	import flash.events.Event;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;


	public class PicturesGalery extends MovieClip 
	{
		const uiAnimationSpeed:Number = 0.5; // Speed of UI changes animations
		const picturesAnimationSpeed:Number = 2; // Speed of pictures hiding and showing
		const preborderSpace:int = 5;

		var picture:MovieClip = new MovieClip(); 
		
		protected var previousPictureIndex:int = -1; //-1 means no picture shown - loading at process.
		protected var activePictureIndex:int = -1; //-1 means no picture shown - loading at process.
		
		protected var isClosing:Boolean = false;
		protected var isLoadingComplete:Boolean = false;
		protected var fileLoadingCompletitionCallbak = fileLoadingCompletion;
		var loadingFileIndex:int = 0;
		public var picturesPaths:Array = [];
		public var picturesTitles:Array = null;
		
		protected var loaders:Array = [];
		
		// Following vars should be specified in sublass constructor defore call parent (this class) constructor
		protected var loadingIndicator, picturesContainer:MovieClip = null;
		protected var nextButton, previousButton:SimpleButton = null;
		protected var titleField:TextField = null;
		
		protected var pictureShowTween:Tween = null;
		protected var pictureHideTween:Tween = null;
		
		public function PicturesGalery() 
		{
			// Constructor is epmty. All tasks from construcotr moves to postConstructInitialization method. This method shoulf be called from subclass constructor, after all connection
			// to UI (nextButton and e.t.c) will be seted.
		}
		
		protected function postConstructInitialization ()
		{
			loadingIndicator.scaleX = previousButton.scaleX = nextButton.scaleX = 1 / this.scaleX;
			loadingIndicator.scaleY = previousButton.scaleY = nextButton.scaleY = 1 / this.scaleY;
			
			previousButton.addEventListener(MouseEvent.CLICK, showPreviousPicture);
			nextButton.addEventListener(MouseEvent.CLICK, showNextPicture);

			clearPicturesContainer();
		}
		
		private function clearPicturesContainer()
		{
			var sourceWidth:int = picturesContainer.width / picturesContainer.scaleX;
			var sourceHeight:int = picturesContainer.height / picturesContainer.scaleY;
			var x:int = picturesContainer.x;
			var y:int = picturesContainer.y;
			picturesContainer.removeChildren();
			
			var holder:Shape = new Shape();
			holder.graphics.beginFill(0x000000);
			holder.graphics.drawRect(- sourceWidth / 2,  - sourceHeight / 2, sourceWidth, sourceHeight);
			holder.graphics.endFill();
			holder.alpha = 0;
			picturesContainer.addChild(holder);
			
			picturesContainer.x = x;
			picturesContainer.y = y;
		}
		
		public function showPicturesWithTitles (paths:Array, titles:Array = null)
		{
			if (paths.length == 0)
			{
				return;
			}
			
			isLoadingComplete = false;
			
			showLoadingUI();
			clearPicturesContainer();
			
			loaders = [];
			picturesPaths = paths;
			picturesTitles = titles;
			loadingFileIndex = 0;
			activePictureIndex = -1;
			
			loadFileAtIndexWithCompletionCallback(0, fileLoadingCompletitionCallbak);
		}
		
		private function loadFileAtIndexWithCompletionCallback(index:int, completionCallback:Function)
		{
			if (isClosing)
				return;
			
			var fs : FileStream = new FileStream();
			var targetFile : File = File.applicationDirectory.resolvePath(picturesPaths[index]);
			
			var ba:ByteArray = new ByteArray;
			
			fs.open(targetFile, FileMode.READ);
			fs.readBytes(ba, 0, fs.bytesAvailable);
			fs.close();
			
			loaders[index] = new Loader();
			loaders[index].contentLoaderInfo.addEventListener(Event.COMPLETE, completionCallback);
			loaders[index].loadBytes(ba);
		}
		
		private function fileLoadingCompletion (e:Event)
		{
			if (isClosing)
				return;
			
			configureLoader(loaders[loadingFileIndex]);
			loadingFileIndex++;
			
			if (loadingFileIndex < picturesPaths.length)
			{
				loadFileAtIndexWithCompletionCallback(loadingFileIndex, fileLoadingCompletion);
			}
			else
			{
				showPictureAtIndex(0);
				isLoadingComplete = true;
				this.showRegularUI();
			}
		}
		
		private function configureLoader(loader:Loader)
		{
			if (isClosing)
				return;
			
			var neededXScale:Number = (picturesContainer.width * this.scaleX - 2 * preborderSpace) / loader.width;
			var neededYScale:Number = (picturesContainer.height * this.scaleY - 2 * preborderSpace) / loader.height;
			
			loader.scaleX = loader.scaleY = Math.min(neededXScale, neededYScale, 1);
			loader.scaleX *= 1 / (this.scaleX * picturesContainer.scaleX);
			loader.scaleY *= 1 / (this.scaleY * picturesContainer.scaleY);
			
			loader.x = - loader.width / 2;
			loader.y = - loader.height / 2;
			
			loader.alpha = 0;
			picturesContainer.addChild(loader);
		}
		
		protected function showPictureAtIndex (index:int)
		{
			if (isClosing)
				return;
			
			if (activePictureIndex != -1)
			{
				previousPictureIndex = activePictureIndex;
				pictureHideTween = new Tween(loaders[activePictureIndex], "alpha", Strong.easeOut, 1, 0, picturesAnimationSpeed, true);
			}
			
			pictureShowTween = new Tween(loaders[index], "alpha", Strong.easeOut, 0, 1, picturesAnimationSpeed, true);
			
			activePictureIndex = index;
			
			if (titleField != null 
				&& picturesTitles != null
				&& picturesTitles.length > index)
				{
					titleField.embedFonts = false;
					titleField.text = picturesTitles[index];
				}
			
		}
		
		protected function showLoadingUI ()
		{
			var loadingIndicatorTween:Tween = new Tween(loadingIndicator, "alpha", Strong.easeOut, loadingIndicator.alpha, 1, uiAnimationSpeed, true);
		}
		
		protected function showRegularUI ()
		{
			var loadingIndicatorTween:Tween = new Tween(loadingIndicator, "alpha", Strong.easeOut, loadingIndicator.alpha, 0, uiAnimationSpeed, true);
		}
		
		private function showNextPicture (e:Event)
		{
			if (!isLoadingComplete)
				return;
			
			if (activePictureIndex == loaders.length - 1)
			{
				showPictureAtIndex(0);
			}
			else
			{
				showPictureAtIndex(activePictureIndex + 1);
			}
		}
		
		private function showPreviousPicture(e:Event)
		{
			if (!isLoadingComplete)
				return;
			
			if (activePictureIndex == 0)
			{
				showPictureAtIndex(loaders.length - 1);
			}
			else
			{
				showPictureAtIndex(activePictureIndex - 1);
			}
		}
	}
}
