//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.System;


class ScheduleViewDelegate extends Ui.BehaviorDelegate {
    //var notify;
    //var direction, directionString;

    // Handle menu button press
    function onMenu() {
    	//Ui.pushView( new ScheduleView(), new ScheduleViewDelegate(), Ui.SLIDE_UP );
    	return true;
    }
    
    function onBack() {
    	//Ui.switchToView(WebRequestView(), WebRequestDelegate(), Ui.SLIDE_UP);
    	popView(Ui.SLIDE_UP);
    	return true;
    }
    
    function onKey(KEY_START) {
        return true;
    }

    function onSelect() {
        return true;
    }


    // Set up the callback to the view
    function initialize() {
        Ui.BehaviorDelegate.initialize();
        //notify = handler;
    }
}