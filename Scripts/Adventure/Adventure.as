package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
		
	public class Adventure extends MovieClip
	{			
		private const buttonsAnimationSpeed = 0.8;
	
		public function Adventure()
		{
			import flash.events.MouseEvent;

			DayMinus2Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			DayMinus1Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day0Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day1Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day2Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day3Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day4Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day5Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day6Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day7Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day8Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day9Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day10Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day11Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
			Day12Link.addEventListener(MouseEvent.CLICK, showFrameRelatedToCaller);
		}
		
		function showFrameRelatedToCaller (e:MouseEvent)
		{
			var frameName:String = e.currentTarget.name.slice(0, -4);
			this.gotoAndStop(frameName);
		}
	}
}
