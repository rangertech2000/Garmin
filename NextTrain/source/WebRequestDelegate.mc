//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;

class WebRequestDelegate extends Ui.BehaviorDelegate {
    var notify;
	var direction;
	
    // Handle menu button press
    function onMenu() {
    	if (direction == 1) {
    		direction = 2;
    	}
    	else {
    		direction = 1;
    	}
    	
        makeRequest(direction);
        return true;
    }

    function onSelect() {
        makeRequest(direction);
        return true;
    }

    function makeRequest(direction) {
        notify.invoke("Executing\nRequest");
        
        var url;
        if (direction == 1) {
        	url = "http://www3.septa.org/hackathon/NextToArrive/Suburban%20Station/Narberth/1";
        }
		else {
			url = "http://www3.septa.org/hackathon/NextToArrive/Narberth/Suburban%20Station/1";
		}
		
        Comm.makeWebRequest(
            url,
            {},
            {
			//:method => Comm.HTTP_REQUEST_METHOD_GET,
			:headers => {"Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON}//,
			//:responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
			},
            method(:onReceive)
        );
    }

    // Set up the callback to the view
    function initialize(handler) {
        Ui.BehaviorDelegate.initialize();
        notify = handler;
    }

    // Receive the data from the web request
    function onReceive(responseCode, data) {
 		data = data[0]; //Convert the array to a dictionary
 		var data_out = {}; // New empty dictionary
 		data_out.put("Train#", data.get("orig_train"));
 		data_out.put("Delay", data.get("orig_delay"));
 		data_out.put("Scheduled", data.get("orig_departure_time"));
 		
	    if (data instanceof Lang.String) {
	        System.println ("data is a String type.");
	        System.println (data);
	    } 
	    else if (data instanceof Dictionary) {
	    	System.println ("data is a Dictionary type.");
	    	
	    	var keys = data.keys();
	    	for( var i = 0; i < keys.size(); i++ ) {
	        	System.println(keys[i] + " : " + data[keys[i]]);
	        }	
	    }   
	     	
        if (responseCode == 200) {
        	System.println ("responseCode: "+ responseCode);
            //notify.invoke(data["args"]);
            notify.invoke(data_out);
            //System.println (data[0]);
        } else {
            notify.invoke("Failed to load\nError: " + responseCode.toString());
        }
    }
}