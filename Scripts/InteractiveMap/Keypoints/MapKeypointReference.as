package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class MapKeypointReference extends MovieClip {

		public function MapKeypointReference() {
			this.addEventListener(MouseEvent.CLICK, presentReference);
		}

		private function presentReference (e:MouseEvent) {
			var referencePanel:ReferencePanel = new ReferencePanel();
			referencePanel.gotoAndStop(this.name);
			stage.addChild(referencePanel);
		}
	}
	
}
