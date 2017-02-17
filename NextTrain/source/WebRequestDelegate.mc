//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.System;

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
    	var url;
    	
    	if (direction == 1) {
			url = "http://www3.septa.org/hackathon/NextToArrive/Suburban%20Station/Narberth/1";   
		}
		else {
			url = "http://www3.septa.org/hackathon/NextToArrive/Narberth/Suburban%20Station/1";   
		}
			 
        notify.invoke("Executing\nRequest");

        Comm.makeWebRequest(
            url,
            {},
            {
            //:method => Comm.HTTP_REQUEST_METHOD_GET,
            //:method => 1//,
            "Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON//,
            //:headers {"Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON}//,
            //:responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
            //:responseType => 0
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
    	data = data[0]; //concert the array to a dictionary type
    	
      	if (data instanceof Lang.Dictionary) {
            System.println("data is a Dictionary.");
            System.println("Dictionary size: " + data.size());
            
            var keys = data.keys();
            for( var i = 0; i < keys.size(); i++ ) {
                //System.println("$1$: $2$\n", [keys[i], data[keys[i]]]);
                System.println(keys[i] + " : " + data[keys[i]]);
                //notify.invoke(keys[i] + " : " + data[keys[i]]);
            }
        } else if (data instanceof Lang.Array) {
            System.println("data is an Array.");
            System.println("Array size: " + data.size());
            System.println(data[0]);
        }      	

        if (responseCode == 200) {
        	System.println("reponseCode: " + responseCode);
            //notify.invoke(data["orig_line"]);
            notify.invoke(data);
        } else {
            notify.invoke("Failed to load\nError: " + responseCode.toString());
        }
    }
}