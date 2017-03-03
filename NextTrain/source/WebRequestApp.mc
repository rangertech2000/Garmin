//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Application as App;
var direction, directionString;
var station1, station2;
var startStation, endStation;
    
class WebRequestApp extends App.AppBase {
    hidden var mView;

    function initialize() {
        App.AppBase.initialize();
        
        station1 = App.getApp().getProperty("station1"); 
        if(station1 == null) {
            station1 = "Narberth";
        }
        
        station2 = App.getApp().getProperty("station2"); 
        if(station2 == null) {
            station2 = "Suburban Station";
        }
        
        System.println(station1);
        System.println(station2); 
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        mView = new WebRequestView();
        return [mView, new WebRequestDelegate(mView.method(:onReceive))];
    }
}