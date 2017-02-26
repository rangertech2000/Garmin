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
    //var direction, directionString;

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
    	
    	var url = "http://www3.septa.org/hackathon/NextToArrive/" + removeSpaces(startStation) + "/" + removeSpaces(endStation) + "/20"; 
		directionString = startStation + "-->" + endStation;
        
        Comm.makeWebRequest(
            url,
            {},
            {"Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON},
            method(:onReceive)
        );
    }


    function removeSpaces(word) {
        var word1, word2;
    	var wordLength = word.length();
    	var space = word.find(" ");
    	
    	while (space != null) {
    		word1 = word.substring(0, space) + "%20";
    		word2 = word.substring(space + 1, wordLength);
    		word = word1 + word2;
    		
    		space = word.find(" ");
    		wordLength = word.length();
    	}
    	return word;
    }
    
    
    // Receive the data from the web request
    function onReceive(responseCode, data) { 
    	var data_out = "Delay    Depart          Arrive\n";
    	    	
      	if (data instanceof Lang.Dictionary) {
            System.println("data is a Dictionary.");
            System.println("Dictionary size: " + data.size());
        } 
        else if (data instanceof Lang.Array) {
            System.println("data is an Array.");
            System.println("Array size: " + data.size());
            
            for (var i = 0; i < data.size(); i++) {
            	var data_temp = data[i]; //convert the array to a dictionary type
            	var delay = data_temp.get("orig_delay");
            	
            	if (delay.equals("On time")) {delay = 0;}
            	else {delay = delay.substring(0, delay.find(" mins")).toNumber();}

            	data_out += Lang.format("$1$m     $2$ --> $3$\n",  
            		[delay.format("%02d"), 
            		data_temp.get("orig_departure_time"), 
            		data_temp.get("orig_arrival_time")]
            		);
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