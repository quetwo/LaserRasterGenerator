/**
 * Created with IntelliJ IDEA.
 * User: Nicholas Kwiatkowski
 * Date: 6/8/2014
 * Time: 4:33 PM
 *
 */
package org.lmn.laserRaster.classes
{
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;

	import spark.primitives.BitmapImage;

    [Event(name="RasterImageUpdate",type="flash.events.Event")]
	public class RasterImage
	{
		[Bindable]
		public var source:BitmapImage = new BitmapImage();

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
            var incomingImage:DisplayObject = loaderInfo.content;
            source.source = incomingImage;
            var e:Event = new Event("RasterImageUpdate");
            dispatchEvent(e);
        }
    }
}
