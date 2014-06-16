/**
 * Created with IntelliJ IDEA.
 * User: Nicholas Kwiatkowski
 * Date: 6/15/2014
 * Time: 7:02 PM
 *
 */
package org.lmn.laserRaster.classes
{
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	import mx.utils.Base64Encoder;

	import org.lmn.laserRaster.LaserConfiguration;

	import org.lmn.laserRaster.LaserConfiguration;

	public class GCodeEncoder
	{

		public function GCodeEncoder()
		{

		}

		static public function generateGCode(incomingBitmap:BitmapData, appliedFilter:ColorMatrixFilter):String
		{
			var gcode:String = LaserConfiguration.PREAMBLE;
			var encoder:Base64Encoder = new Base64Encoder();

			var color:uint;
			var red:uint;
			var green:uint;
			var blue:uint;
			var bwColor:uint;

			var ba:ByteArray = new ByteArray();

			encoder.insertNewLines = false;

			incomingBitmap.applyFilter(incomingBitmap, new Rectangle(0, 0, incomingBitmap.width, incomingBitmap.height),
					new Point(), appliedFilter);

			for (var y:int = 0; y < incomingBitmap.height; y++)
			{
				ba.clear();
				for (var x:int = 0; x < incomingBitmap.width; x++)
				{
					color = incomingBitmap.getPixel(x, y);     //scan each pixel in the image
					red = color & 0xFF0000 >> 16;
					green = color & 0x00FF00 >> 8;
					blue = color & 0x0000FF >> 0;
					bwColor = (red + green + blue) / 3;         //take the average of the RGB value to get the greyscale

					ba.writeUnsignedInt(bwColor);
				}
				ba.position = 0;
				encoder.encodeBytes(ba, 0, incomingBitmap.width);
				gcode = gcode + "G7 N" + (y % 2).toString() + " L" + incomingBitmap.width.toString() + " D" + encoder.toString() + "\n";
			}

			gcode = gcode + "\n" + LaserConfiguration.POSTAMBLE;

			return gcode;
		}

	}
}
