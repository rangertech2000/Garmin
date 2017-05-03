using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class Station1ChooserDelegate extends Ui.PickerDelegate {
	hidden var wView;
	
	function initialize() {
        PickerDelegate.initialize();
	}
	
    function onCancel() {
        System.exit();
    }

    function onAccept(values) {
    	App.getApp().setProperty("station1", values[0]); 
    	//wView = new WebRequestView();
    	//Ui.pushView(wView, new WebRequestDelegate(wView.method(:onReceive)), Ui.SLIDE_IMMEDIATE);
    	Ui.popView(Ui.SLIDE_IMMEDIATE);
    }
}
