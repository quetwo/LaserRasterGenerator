LaserRasterGenerator
====================

AS3 Project to generate raster GCode from images for the laser cutters based on the Marlin Firmware, like the one in
use at the Lansing Makers Network.

This project will allow users to open JPEG, PNG and GIF graphic formats and set the rotation, crop the image, set the
black and white color correction and resize the image.  It will output GCode that will send raster pulses using the G7
GCode command. 

TODO:
-----
 - Options screen for exporting GCode.
 - Update GCode export option to use green threading to stop the freeze in UI when exporting large images.
 - Allow user to export settings they made on an image.
 - Create an AIR version and provide native versions.
    - Include ability to directly control the cutter right from AIR app.
 - Include logic to make sure the image is not larger than the "printable" area of the laser cutter.    
    
Modifying and Compiling:
------------------------
 1. Download Apache Flex (baseline version is built on 4.12, but any version 4.6+ should work).  http://flex.apache.org
 2. Modify the org.lmn.laserRaster.LaserConfiguration file to match your laser cutter's settings.
 3. Compile with default settings.  If you are making a production, don't deploy the debugging version of the SWF
 
Resources:
----------
 - Apache Flex (http://flex.apache.org)
 - Lansing Maker's Network (http://www.lansingmakersnetwork.org)
 - LMN's Laser Cutter details (http://wiki.lansingmakersnetwork.org/equipment/buildlog_laser_cutter)
 - Marlin Firmware (LMN Edition) (https://github.com/lansing-makers-network/buildlog-lasercutter-marlin) 
