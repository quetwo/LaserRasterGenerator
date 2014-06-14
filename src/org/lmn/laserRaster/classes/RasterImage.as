/**
 * Created with IntelliJ IDEA.
 * User: Nicholas Kwiatkowski
 * Date: 6/8/2014
 * Time: 4:33 PM
 *
 */
package org.lmn.laserRaster.classes
{
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;

	import spark.primitives.BitmapImage;

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
			trace("Loaded File");
			source.source = fr.data;
		}


	}
}
