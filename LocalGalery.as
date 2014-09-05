package  {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Scene;

	public class LocalGalery extends PicturesGalery 
	{
		
		public function LocalGalery ()
		{
			nextButton = localNextButton;
			previousButton = localPreviousButton;
			loadingIndicator = localLoadingIndicator;
			picturesContainer = localPicturesContainer;
			
			picturesContainer.addEventListener(MouseEvent.CLICK, showGlobalGalery);
			
			super.postConstructInitialization();
		}
		
		private function showGlobalGalery (e:Event)
		{
			var globalGalery:GlobalGalery = new GlobalGalery();
			globalGalery.picturesPaths = picturesPaths;
			globalGalery.picturesTitles = picturesTitles;
			stage.addChild(globalGalery);
		}
	}
}
