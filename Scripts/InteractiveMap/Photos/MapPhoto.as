package  {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class MapPhoto extends MovieClip {

		public function MapPhoto() {
			this.addEventListener(MouseEvent.CLICK, showPhoto);
		}
		
		private function showPhoto(e:MouseEvent) {
			var globalGalery:GlobalGalery = new GlobalGalery();
			globalGalery.picturesPaths = ["Images/Map/" + this.name + ".jpg"];
			globalGalery.picturesTitles = [""];
			stage.addChild(globalGalery);
		}
	}
}
