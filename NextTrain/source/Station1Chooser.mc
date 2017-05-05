using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class Station1Chooser extends Ui.Picker {
	var title;
	var factory;
	
    function initialize() {
        title = new Ui.Text({:text=>Rez.Strings.Station1ChooserTitle, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        factory = new WordFactory();
        Picker.initialize({:title=>title, :pattern=>[factory]});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}
