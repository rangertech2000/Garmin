//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.System;


class ScheduleViewDelegate extends Ui.BehaviorDelegate {
    var notify;
    var direction, directionString;

    // Handle menu button press
    function onMenu() {
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
    function initialize(handler) {
        Ui.BehaviorDelegate.initialize();
        notify = handler;
    }
    
    function makeRequest(direction) {
    	notify.invoke("Executing\nRequest");
    	
    	var url;
    	if (direction == 1) {
			url = "http://www3.septa.org/hackathon/NextToArrive/Narberth/Suburban%20Station/20"; 
			directionString = "Inbound";
		}
		else {
			url = "http://www3.septa.org/hackathon/NextToArrive/Suburban%20Station/Narberth/20";  
			directionString = "Outbound";  
		}
        
        
        Comm.makeWebRequest(
            url,
            {},
            {"Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON},
            method(:onReceive)
        );
    }

    // Receive the data from the web request
    function onReceive(responseCode, data) { 
    	//data = data[0]; //concert the array to a dictionary type
    	
    	var data_out = {};
    	//var data_out = {"Depart Time"=>data.get("orig_departure_time"),
    	//	"Delay"=>data.get("orig_delay"),
    	//	"Direction"=>directionString};
    	    	
      	if (data instanceof Lang.Dictionary) {
            System.println("data is a Dictionary.");
            System.println("Dictionary size: " + data.size());
            
            //var keys = data.keys();
            //for( var i = 0; i < keys.size(); i++ ) {
            //    System.println(keys[i] + " : " + data[keys[i]]);
            //}
        } 
        else if (data instanceof Lang.Array) {
            System.println("data is an Array.");
            System.println("Array size: " + data.size());
            
            for (var i = 0; i < data.size(); i++) {
            	System.println(data[i]);
            	var data_temp = data[i]; //convert the array to a dictionary type
            	data_out.put("Depart_Time_" + i.toString(), data_temp.get("orig_departure_time"));
            }
        }      	

        if (responseCode == 200) {
        	System.println("reponseCode: " + responseCode);
            notify.invoke(data_out);
        } else {
            notify.invoke("Failed to load\nError: " + responseCode.toString());
        }
    }
}