/**
 * Created by Nicholas on 6/21/2014.
 */
package org.lmn.laserRaster.classes
{
import flash.events.Event;

public class ColorChangeEvent extends Event
{
    public function ColorChangeEvent(mytype:String,bubbles:Boolean = false,cancelable:Boolean = false)
    {
        super(mytype, bubbles, cancelable);
    }
}
}
