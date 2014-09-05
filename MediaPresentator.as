package 
{
	import flash.display.MovieClip;
	import flash.geom.Matrix;

	public class MediaPresentator extends MovieClip
	{
		var pictureLoader:PictureLoader;

		public function MediaPresentator()
		{
			pictureLoader = new PictureLoader();
			
			this.visible = false;
		}

		public function configureLayout()
		{
			var tm:Matrix = new Matrix();
			tm.translate(parent.width / 2, parent.height / 2);
			pictureLoader.transform.matrix = tm;
			pictureLoader.width = 300;
			pictureLoader.height = 300;
			pictureLoader.x = 0;
			pictureLoader.y = 0;

			this.width = parent.width;
			this.height = parent.height;
			this.x = parent.width / 2;
			this.y = parent.height / 2;
			
//			parent.swapChildren(this, parent.getChildAt(1));
/*			var currentIndex:int = parent.getChildIndex(this);
			for (;cureentIndex < 0; currentIndex--)
			{
				parent.swapChildren(
									parent.addChildAt(
			}*/
		}

		private function show()
		{
			

			this.visible = true;
		}

		public function presentPictureFromURL(url:String)
		{
			this.show();
			pictureLoader.loadFromUrl(url);
		}
	}

}