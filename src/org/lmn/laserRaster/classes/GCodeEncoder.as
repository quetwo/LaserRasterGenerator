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
			var color:uint;
			var red:uint;
			var green:uint;
			var blue:uint;
			var bwColor:uint;

			var ba:ByteArray = new ByteArray();

			var encoder:Base64Encoder = new Base64Encoder();
			encoder.insertNewLines = false;

			var myImage:BitmapData = incomingBitmap.clone();
            var buffer:String;

			myImage.applyFilter(myImage, new Rectangle(0, 0, myImage.width, myImage.height),
					new Point(), appliedFilter);

			for (var y:int = 0; y < myImage.height; y++)
			{
				ba.clear();
				for (var x:int = 0; x < myImage.width; x++)
				{
					color = myImage.getPixel(x, y);     //scan each pixel in the image
					red = color & 0xFF0000 >> 16;
					green = color & 0x00FF00 >> 8;
					blue = color & 0x0000FF >> 0;
					bwColor = (red + green + blue) / 3;         //take the average of the RGB value to get the greyscale

					ba.writeUnsignedInt(bwColor);
				}
				ba.position = 0;
                buffer = "";
                for(var bufferWidth:int = 0; bufferWidth < myImage.width; bufferWidth = bufferWidth + 50)
                {
                    buffer = "G7 ";
                    if(bufferWidth == 0) buffer = buffer + "N" + (y % 2).toString() + " ";
                    if((bufferWidth + 50) < myImage.width)
                    {
                        buffer = buffer + "L50 ";
                    }
                    else
                    {
                        buffer = buffer + "L" + (myImage.width - bufferWidth).toString() + " ";
                    }
                    encoder.encodeBytes(ba,bufferWidth,50);
                    gcode = gcode + buffer + "D" + encoder.toString() + " F" + LaserConfiguration.SPEED.toString() + "\n";
                }
				//encoder.encodeBytes(ba, 0, myImage.width);
				//gcode = gcode + "G7 N" + (y % 2).toString() + " L" + myImage.width.toString() + " D" + encoder.toString() + "\n";
			}

			gcode = gcode + "\n" + LaserConfiguration.POSTAMBLE;

			return gcode;
		}

	}
}
