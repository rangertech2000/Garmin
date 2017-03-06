using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class Station1Chooser extends Ui.Picker {

    function initialize() {
        var title = new Ui.Text({:text=>Rez.Strings.Station1ChooserTitle, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        //var factory = new WordFactory([Rez.Strings.pickerChooserColor, Rez.Strings.pickerChooserDate, Rez.Strings.pickerChooserString, Rez.Strings.pickerChooserTime, Rez.Strings.pickerChooserLayout], {:font=>Gfx.FONT_MEDIUM});
        var factory = new WordFactory(["Narberth", "Merion", "Overbrook", "Wissahickon"], {:font=>Gfx.FONT_MEDIUM});
        Picker.initialize({:title=>title, :pattern=>[factory]});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class Station1ChooserDelegate extends Ui.PickerDelegate {
	hidden var wView;
	
    function onCancel() {
        System.exit();
    }

    function onAccept(values) {
    	App.getApp().setProperty("station1", values[0]); 
    	wView = new WebRequestView();
    	Ui.pushView(wView, new WebRequestDelegate(wView.method(:onReceive)), Ui.SLIDE_IMMEDIATE);
    }
}
