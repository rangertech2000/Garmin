using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.System;


class WebRequestDelegate extends Ui.BehaviorDelegate {
    var notify;
    hidden var sView;

    // Handle menu button press
    function onMenu() {
    	sView = new ScheduleView();
    	Ui.pushView(sView, new ScheduleViewDelegate(sView.method(:onReceive)), Ui.SLIDE_UP );
    	return true;
    }
    
    function onBack() {
    	//System.exit();
    	
    	Ui.pushView(new Station1Picker(), new Station1PickerDelegate(), Ui.SLIDE_IMMEDIATE);
    	return true;
    }
    
    // Change direction
    function onKey(KEY_START) {
    	changeDirection();
        makeRequest(direction);
        return true;
    }
	
	// Refresh the data
    function onSelect() {
        makeRequest(direction);
        return true;
    }
    
    // Set up the callback to the view
    function initialize(handler) {
        Ui.BehaviorDelegate.initialize();
        notify = handler;
    }

    function makeRequest(direction) {
    	notify.invoke("Executing\nRequest");
   		
   		if (direction == null) { changeDirection(); }
   		
    	var url = "http://www3.septa.org/hackathon/NextToArrive/" + replaceSpaces(startStation) + "/" + replaceSpaces(endStation) + "/1"; 
		directionString = startStation + "\n--> " + endStation;
        
        Comm.makeWebRequest(
            url,
            {},
            {
            //:method => Comm.HTTP_REQUEST_METHOD_GET,
            "Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON//,
            //:headers {"Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON}//,
            //:responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
             },
            method(:onReceive)
        );
    }
    
    function replaceSpaces(word) {
        var word1, word2;
    	var wordLength = word.length();
    	var space = word.find(" ");
    	// Remove any spaces
    	while (space != null) {
    		word1 = word.substring(0, space) + "%20";
    		word2 = word.substring(space + 1, wordLength);
    		word = word1 + word2;
    		space = word.find(" ");
    		wordLength = word.length();
    	}
    	return word;
    }
    
        function formatTime(word) {
        var word1, word2;
    	var wordLength = word.length();
    	var space = word.find(" ");
    	// Remove any spaces
    	while (space != null) {
    		word1 = word.substring(0, space);
    		word2 = word.substring(space + 1, wordLength);
    		word = word1 + word2;
    		space = word.find(" ");
    		wordLength = word.length();
    	}
    	// Remove the trailing "M"
    	word = word.substring(0, wordLength - 1); 
    	return word;
    }

    function changeDirection() {
	    if (direction == 1) {
	    		direction = 2;
	    		startStation = station2;
	    		endStation = station1;
	    	}
	    	else {
	    		direction = 1;
	    		startStation = station1;
	    		endStation = station2;
	    	}
    }
    
    // Receive the data from the web request
    function onReceive(responseCode, data) { 
		if (responseCode == 200) {
        	System.println("reponseCode: " + responseCode);
        	
        	var data_text = "";
        	
	      	if (data instanceof Lang.Dictionary) {
	            System.println("data is a Dictionary.");
	            System.println("Dictionary size: " + data.size());
	            
	            var keys = data.keys();
	            for( var i = 0; i < keys.size(); i++ ) {
	                System.println(keys[i] + " : " + data[keys[i]]);
	            }
	        } 
	        else if (data instanceof Lang.Array) {
	            System.println("data is an Array.");
	            System.println("Array size: " + data.size());
	            //System.println(data[0]);
	            
	            if (data.size() > 0) {    	
		    		data = data[0]; //convert the array to a dictionary type
		    	
			    	var delay = data.get("orig_delay");
			    	if (!delay.equals("On time")) {
			    		delay = delay + " delayed";
			    	}
			            	
			    	data_text = {
			    	"Depart Time"=>formatTime(data.get("orig_departure_time"))
			    	,"Delay"=>delay
			    	};
		    	}
		    	else {
		    		data_text = "No trains\navailable";
		    	}    	
	        }      	
            notify.invoke(data_text);
        } 
        else {
            notify.invoke("Failed to load\nError: " + responseCode.toString());
        }
    }
}