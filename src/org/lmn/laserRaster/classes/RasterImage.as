/**
 * Created with IntelliJ IDEA.
 * User: Nicholas Kwiatkowski
 * Date: 6/8/2014
 * Time: 4:33 PM
 *
 */
package org.lmn.laserRaster.classes
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.net.FileFilter;
	import flash.net.FileReference;

	import org.lmn.laserRaster.LaserConfiguration;

	import spark.primitives.BitmapImage;

	//bwMatrix = [rcontrastSlider.value, gcontrastSlider.value, bcontrastSlider.value, 0, 0,
	//    rcontrastSlider.value, gcontrastSlider.value, bcontrastSlider.value, 0, 0,
	//    rcontrastSlider.value, gcontrastSlider.value, bcontrastSlider.value, 0, 0,
	//    0, 0, 0, 1, 0];
	//bwFilter = new ColorMatrixFilter(bwMatrix);


    [Event(name="RasterImageUpdate",type="flash.events.Event")]
	public class RasterImage
	{
		public var source:Bitmap = new Bitmap();
		public var bwMatrix:Array;
		public var bwFilter:ColorMatrixFilter;

		[Bindable]
		public var imageLoaded:Boolean = false;

		private var fr:FileReference = new FileReference();

		public function RasterImage()
		{
			fr.addEventListener(Event.SELECT, selectedFile);
			fr.addEventListener(Event.COMPLETE, fileLoaded);
		}

		public function loadImageFromDisk():void
		{
			var fileImageFilter:FileFilter = new FileFilter("Image Files (*.jpg, *.jpeg, *.gif, *.png)","*.jpg;*.jpeg;*.png;*.gif");
			fr.browse([fileImageFilter]);

		}

		private function selectedFile(event:Event):void
		{
			fr.load();
		}

		private function fileLoaded(event:Event):void
		{
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadBytesHandler);
            loader.loadBytes(fr.data);
		}

        private function loadBytesHandler(event:Event):void
        {
            var loaderInfo:LoaderInfo = (event.target as LoaderInfo);
            loaderInfo.removeEventListener(Event.COMPLETE, loadBytesHandler);
			source = loaderInfo.content as Bitmap;
			imageLoaded = true;
            var e:Event = new Event("RasterImageUpdate");
            dispatchEvent(e);
        }

		public function get imageWidthInMM():Number
		{
			return source.width / LaserConfiguration.PPMM;
		}

		public function get imageHeightInMM():Number
		{
			return source.height / LaserConfiguration.PPMM;
		}

		public function get imageWidthInInch():Number
		{
			return source.width / LaserConfiguration.PPI;
		}

		public function get imageHeightInInch():Number
		{
			return source.height / LaserConfiguration.PPI;
		}
    }
}
