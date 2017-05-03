using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class WebRequestView extends Ui.View {
    hidden var mMessage = "Press menu button";
    hidden var mModel;
    
    function initialize() {
        Ui.View.initialize();
        
        station1 = App.getApp().getProperty("station1"); 
        if(station1 == null) {
            station1 = "Narberth";
            App.getApp().setProperty("station1", station1); 
        }
        else {
        	startStation = station1;
        }
        	
        station2 = App.getApp().getProperty("station2"); 
        if(station2 == null) {
            station2 = "Suburban Station";
            App.getApp().setProperty("station2", station2); 
        }
        else {
        	endStation = station2;
        }	
 
    }

    // Load your resources here
    function onLayout(dc) {
    	setLayout(Rez.Layouts.WatchFace(dc));
    	
        mMessage = "Requesting Data...";
        
        // Retrieve data on page load
        var v = new WebRequestDelegate(WebRequestView.method(:onReceive));
    	// Get the callback for the onReceive method.
    	var m = v.method(:makeRequest);
    	// Invoke v's makeRequest method.
    	mMessage = m.invoke(direction);
        
    }

    // Restore the state of the app and prepare the view to be shown
    function onShow() {
    	station1 = App.getApp().getProperty("station1"); 
    	station2 = App.getApp().getProperty("station2"); 
    }

    // Update the view
    function onUpdate(dc) {
    
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var ap;
        var hour = clockTime.hour; 
        	if (hour < 1) {
        		hour = 12;
        		ap = "AM";
        	} 	
        	else if (hour > 12) {
        		hour = hour - 12;
        		ap = "PM";
        	}
        	else {
        		if(hour > 11) {
        			ap = "PM";
        		}
        		else {
        			ap = "AM";
        		}	
        	}	
        var timeString = Lang.format("$1$:$2$:$3$ $4$", [hour, clockTime.min.format("%02d"), clockTime.sec.format("%02d"), ap]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);
        
        var viewDirection = View.findDrawableById("DirectionLabel");
        viewDirection.setText(directionString);
              
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        //dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        //dc.clear();
        //dc.drawText(dc.getWidth()/2, 100, Gfx.FONT_MEDIUM, mMessage, Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
        
    }

    // Called when this View is removed from the screen. Save the
    // state of your app here.
    function onHide() {
    }

    function onReceive(args) {
    	var viewDepart = View.findDrawableById("DepartLabel");
    	var viewDelay = View.findDrawableById("DelayLabel");
    
        if (args instanceof Lang.String) {
        	System.println("args is a String type.");
        	System.println("args: " + args.toString());
        	//mMessage = args;
            viewDelay.setText(args);
        }
        else if (args instanceof Lang.Dictionary) {
            // Print the arguments duplicated and returned by httpbin.org
            System.println("args is a Dictionary type.");
            var keys = args.keys();
            //mMessage = "";
            
            //for( var i = 0; i < keys.size(); i++ ) {
            //    mMessage += Lang.format("$1$: $2$\n", [keys[i], args[keys[i]]]);
            //}
            
        	viewDepart.setText(args.get("Depart Time"));
        	viewDelay.setText(args.get("Delay"));        
        }
        
        Ui.requestUpdate();
    }
}
