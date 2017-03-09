using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System;

class Station1Picker extends Ui.View {

    function initialize() {
    	Ui.View.initialize();
    
        //var title = new Ui.Text({:text=>Rez.Strings.Station1ChooserTitle, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        //var factory = new WordFactory(["Narberth", "Merion", "Overbrook", "Wissahickon"], {:font=>Gfx.FONT_MEDIUM});
        //Picker.initialize({:title=>title, :pattern=>[factory]});
    }

	function onLayout(dc) {
    	setLayout(Rez.Layouts.Station1Picker(dc));
    }
    	
    // Restore the state of the app and prepare the view to be shown
    function onShow() {
    	System.println("Picker initialized");
    }

    // Update the view
    function onUpdate(dc) {	
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        View.onUpdate(dc);
    }
}