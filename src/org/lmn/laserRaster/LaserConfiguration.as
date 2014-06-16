/**
 * Created with IntelliJ IDEA.
 * User: Nicholas Kwiatkowski
 * Date: 6/15/2014
 * Time: 11:08 PM
 *
 */
package org.lmn.laserRaster
{
	public class LaserConfiguration
	{
		public static const PREAMBLE:String = "M106 ;turn on stepper fan\n" +
				"M80   ; enable accessories\n" +
				"M84   ; disable steppers\n" +
				"G21   ; set units to mm\n" +
				"G90   ; set absolute positioning\n" +
				"G92 X0 Y0 ; zero axis\n";

		public static const POSTAMBLE:String = "M5\n" +
				"G0 X0 Y0 F4000	; End of path\n" +
				"G90   ; set absolute positioning\n" +
				"M107  ;turn off stepper fan\n" +
				"M81   ; disable accessories";

		public static const PPMM:Number = 10;  //Pixels per Millimeter
		public static const PPI:Number = PPMM * 0.0393701;  //Pixels per Inch

		public function LaserConfiguration()
		{
		}
	}
}
