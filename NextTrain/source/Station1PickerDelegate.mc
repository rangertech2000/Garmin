using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System;

class Station1PickerDelegate extends Ui.BehaviorDelegate {
	hidden var wView;
	
	// Set up the callback to the view
    function initialize() {
        Ui.BehaviorDelegate.initialize();
    }
	
    function onBack() {
        System.exit();
    }

	// Handle menu button press
    function onMenu() {
    }
    
    //function onAccept(values) {
    //	App.getApp().setProperty("station1", values[0]); 
    //	wView = new WebRequestView();
    //	Ui.pushView(wView, new WebRequestDelegate(wView.method(:onReceive)), Ui.SLIDE_IMMEDIATE);
    //}
}
