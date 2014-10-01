package  {

	import flash.display.Stage;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import fl.motion.Color;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.geom.ColorTransform;
	import fl.transitions.TweenEvent;
	import flash.display.Loader;

	public class GlobalGalery extends PicturesGalery 
	{
		const horizontalSpace:Number = 0.05;
		const verticalSpace:Number = 0.05;
		const borderWidth:int = 30;
		const borderHeight:int = 38;
		
		var hideCloseButtonTween:Tween = null;
		var showCloseButtonTween:Tween = null;
		
		public function GlobalGalery() 
		{
			nextButton = globalNextButton;
			previousButton = globalPreviousButton;
			loadingIndicator = globalLoadingIndicator;
			picturesContainer = globalPicturesContainer;
			titleField = globalTitleContainer.titleField;
			
			globalTitleContainer.setText("");
			
			if (stage != null)
			{
				setupToStage(null);
			}
			else
			{
				this.addEventListener(Event.ADDED_TO_STAGE, setupToStage);
			}
			
			globalCloseButton.addEventListener(MouseEvent.CLICK, closeSelf);
			
			super.postConstructInitialization();
		}
		
		private function closeSelf (e:Event)
		{
			this.isClosing = true;
			
			if (this.pictureShowTween)
				this.pictureShowTween.stop();
				
			if (this.pictureHideTween)
				this.pictureHideTween.stop();
			
			if (this.isLoadingComplete)
			{
				var lastHideTween:Tween = null;
				
				if (activePictureIndex != -1)
					var hideActiveTween:Tween = lastHideTween = new Tween(loaders[activePictureIndex], "alpha", Strong.easeOut, loaders[activePictureIndex].alpha, 0, uiAnimationSpeed, true);
					
				
				if (previousPictureIndex != -1)
					var hidePreviousTween:Tween = lastHideTween = new Tween(loaders[previousPictureIndex], "alpha", Strong.easeOut, loaders[previousPictureIndex].alpha, 0, uiAnimationSpeed, true);
				
				lastHideTween.addEventListener(TweenEvent.MOTION_FINISH, animatedHideSelf);
			}
			else
			{
				animatedHideSelf(null);
			}
		}
		
		private function animatedHideSelf (e:Event)
		{
			if (loaders[activePictureIndex] != null)
				this.picturesContainer.removeChild(loaders[activePictureIndex]);
				
			if (loaders[previousPictureIndex] != null)
				this.picturesContainer.removeChild(loaders[previousPictureIndex]);
				
			loaders.length = 0;
			var scaleXTween:Tween = new Tween(this, "scaleX", Strong.easeOut, this.scaleX, 0, 1, true);
			var scaleYTween:Tween = new Tween(this, "scaleY", Strong.easeOut, this.scaleY, 0, 1, true);
			scaleYTween.addEventListener(TweenEvent.MOTION_FINISH, removeSelfFromStage);
		}
		
		private function removeSelfFromStage (e:Event)
		{
			stage.removeChild(this);
		}
		
		private function setupToStage (e:Event)
		{
			this.width = stage.stageWidth * (1 - 2 * horizontalSpace) - 2 * borderWidth;
			this.height = stage.stageHeight * (1 - 2 * verticalSpace) - 2 * borderHeight;
			this.x = stage.stageWidth / 2;
			this.y = stage.stageHeight / 2;
			
			loadingIndicator.scaleX = previousButton.scaleX = nextButton.scaleX = globalCloseButton.scaleX = 1 / this.scaleX;
			loadingIndicator.scaleY = previousButton.scaleY = nextButton.scaleY = globalCloseButton.scaleY = 1 / this.scaleY;			
						
			var bitmapData:BitmapData = new GlobalGaleryBottomLeft(0,0);

			var compensativeScaleX:Number = 1 / this.scaleX;
			var compensativeScaleY:Number = 1 / this.scaleY;
			var cornerWidth:Number = bitmapData.width - 1;
			var cornerHeight:Number = bitmapData.height;
			var horizontalElementWidth:Number = (picturesContainer.width * this.scaleX) - 2 * (cornerWidth - borderWidth);
			var verticalElementHeight:Number = (picturesContainer.height * this.scaleY) - 2 * (cornerHeight - borderHeight);
			
			var bottomLeft:Shape = new Shape();
			bottomLeft.graphics.beginBitmapFill(bitmapData);
			bottomLeft.graphics.drawRect(0,0,cornerWidth,cornerHeight);
			bottomLeft.graphics.endFill();
			bottomLeft.x = - (picturesContainer.width / 2) - (borderWidth * compensativeScaleX);
			bottomLeft.y = picturesContainer.height / 2 + ((borderHeight - bitmapData.height) * compensativeScaleY);
			bottomLeft.scaleX = compensativeScaleX;
			bottomLeft.scaleY = compensativeScaleY;
			this.addChild(bottomLeft);
			
			var topLeft:Shape = new Shape();
			topLeft.graphics.beginBitmapFill(bitmapData);
			topLeft.graphics.drawRect(0,0,cornerWidth,cornerHeight);
			topLeft.graphics.endFill();
			topLeft.x = - (picturesContainer.width / 2) - (borderWidth * compensativeScaleX);
			topLeft.y = - picturesContainer.height / 2 - ((borderHeight - cornerHeight) * compensativeScaleY);
			topLeft.rotation = 180;
			topLeft.scaleX = -compensativeScaleX;
			topLeft.scaleY = compensativeScaleY;
			this.addChild(topLeft);
			
			var topRight:Shape = new Shape();
			topRight.graphics.beginBitmapFill(bitmapData);
			topRight.graphics.drawRect(0,0,cornerWidth,cornerHeight);
			topRight.graphics.endFill();
			topRight.x = picturesContainer.width / 2 + borderWidth * compensativeScaleX;
			topRight.y = - picturesContainer.height / 2 - ((borderHeight - cornerHeight) * compensativeScaleY);
			topRight.rotation = 180;
			topRight.scaleX = compensativeScaleX;
			topRight.scaleY = compensativeScaleY;
			this.addChild(topRight);
			
			var bottomRight:Shape = new Shape();
			bottomRight.graphics.beginBitmapFill(bitmapData);
			bottomRight.graphics.drawRect(0,0,cornerWidth,cornerHeight);
			bottomRight.graphics.endFill();
			bottomRight.x = picturesContainer.width / 2 + borderWidth * compensativeScaleX;
			bottomRight.y = picturesContainer.height / 2 - ((cornerHeight - borderHeight) * compensativeScaleY);
			bottomRight.scaleX = -compensativeScaleX;
			bottomRight.scaleY = compensativeScaleY;
			this.addChild(bottomRight);
			
			bitmapData = new GlobalGaleryBottom(0,0);
			
			var bottom:Shape = new Shape();
			bottom.graphics.beginBitmapFill(bitmapData);
			bottom.graphics.drawRect(0,0, horizontalElementWidth, bitmapData.height);
			bottom.graphics.endFill();
			bottom.x = - picturesContainer.width / 2 + ((cornerWidth - borderWidth) * compensativeScaleX);
			bottom.y = picturesContainer.height / 2 - ((bitmapData.height - borderHeight) * compensativeScaleY);
			bottom.scaleX = compensativeScaleX;
			bottom.scaleY = compensativeScaleY;
			this.addChild(bottom);
			
			var top:Shape = new Shape();
			top.graphics.beginBitmapFill(bitmapData);
			top.graphics.drawRect(0,0, horizontalElementWidth, bitmapData.height);
			top.graphics.endFill();
			top.x = - picturesContainer.width / 2 + ((cornerWidth - borderWidth) * compensativeScaleX);
			top.y = - picturesContainer.height / 2 + ((bitmapData.height - borderHeight) * compensativeScaleY);
			top.scaleX = compensativeScaleX;
			top.scaleY = -compensativeScaleY;
			this.addChild(top);
			
			bitmapData = new GlobalGaleryLeft(0,0);
			
			var left:Shape = new Shape();
			left.graphics.beginBitmapFill(bitmapData);
			left.graphics.drawRect(0,0, bitmapData.width, verticalElementHeight);
			left.graphics.endFill();
			left.x = - picturesContainer.width / 2 - (borderWidth * compensativeScaleX);
			left.y = - picturesContainer.height / 2 + ((cornerHeight - borderHeight) * compensativeScaleY);
			left.scaleX = compensativeScaleX;
			left.scaleY = compensativeScaleY;
			this.addChild(left);
			
			var right:Shape = new Shape();
			right.graphics.beginBitmapFill(bitmapData);
			right.graphics.drawRect(0,0, bitmapData.width, verticalElementHeight);
			right.graphics.endFill();
			right.x = picturesContainer.width / 2 + (borderWidth * compensativeScaleX);
			right.y = - picturesContainer.height / 2 + ((cornerHeight - borderHeight) * compensativeScaleY);
			right.scaleX = -compensativeScaleX;
			right.scaleY = compensativeScaleY;
			this.addChild(right);

			var scaleXTween:Tween = new Tween(this, "scaleX", Strong.easeOut, 0, this.scaleX, 1, true);
			var scaleYTween:Tween = new Tween(this, "scaleY", Strong.easeOut, 0, this.scaleY, 1, true);
			scaleYTween.addEventListener(TweenEvent.MOTION_FINISH, presentationComplete);
			
			if (this.picturesPaths.length < 2)
			{
				if((getChildByName("globalNextButton") != null)
				   && (getChildByName("globalPreviousButton") != null))
				{
					this.removeChild(nextButton);
					this.removeChild(previousButton);
				}
			}
			else
			{
				if((getChildByName("sglobalNextButton") == null)
				   && (getChildByName("globalPreviousButton") == null))
				{
					this.addChild(nextButton);
					this.addChild(previousButton);
				}
			}
		}
		
		private function presentationComplete (e:Event)
		{
			this.showPicturesWithTitles(this.picturesPaths, this.picturesTitles);
		}
		
		override protected function showPictureAtIndex (index:int)
		{
			super.showPictureAtIndex(index);
			
			if (index < picturesTitles.length)
				globalTitleContainer.setText(picturesTitles[index]);
			else
				globalTitleContainer.setText("");
		}
	}
}
