using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class Station1ChooserDelegate extends Ui.PickerDelegate {
	hidden var wView;
	
	function initialize() {
        Ui.PickerDelegate.initialize();
    }

    function onCancel() {
        System.exit();
    }

    function onAccept(values) {
    	App.getApp().setProperty("station1", values[0]); 
    	Ui.popView(Ui.SLIDE_IMMEDIATE);
    }
}
