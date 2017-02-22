//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class WebRequestView extends Ui.View {
    hidden var mMessage = "Press menu button";
    hidden var mModel;

    function initialize() {
        Ui.View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	setLayout(Rez.Layouts.WatchFace(dc));
    	
        mMessage = "Press menu or\nselect button";
    }

    // Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
       
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);
        
        //var viewDirection = View.findDrawableById("DirectionLabel");
        //viewDirection.setText(direction);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        //dc.clear();
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Gfx.FONT_MEDIUM, mMessage, Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
        
        
            }

    // Called when this View is removed from the screen. Save the
    // state of your app here.
    function onHide() {
    }

    function onReceive(args) {
        if (args instanceof Lang.String) {
        	System.println("args is a String type.");
        	System.println("args: " + args.toString());
            mMessage = args;
        }
        else if (args instanceof Lang.Dictionary) {
            // Print the arguments duplicated and returned by httpbin.org
            System.println("args is a Dictionary type.");
            var keys = args.keys();
            mMessage = "";
            
            for( var i = 0; i < keys.size(); i++ ) {
                mMessage += Lang.format("$1$: $2$\n", [keys[i], args[keys[i]]]);
            }
        }
        
        Ui.requestUpdate();
    }
}
