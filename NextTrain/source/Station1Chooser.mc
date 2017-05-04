using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class Station1Chooser extends Ui.Picker {
	var title;
	var factory;
	
    function initialize() {
<<<<<<< Upstream, based on branch 'feature1' of https://github.com/rangertech2000/Garmin.git
        title = new Ui.Text({:text=>Rez.Strings.Station1ChooserTitle, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        factory = new WordFactory();
=======
        var title = new Ui.Text({:text=>Rez.Strings.Station1ChooserTitle, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        //var factory = new WordFactory(["Narberth", "Merion", "Overbrook", "Wissahickon"], {:font=>Gfx.FONT_MEDIUM});
        var factory = new WordFactory();
>>>>>>> 6370fff v.b.0.7.2
        Picker.initialize({:title=>title, :pattern=>[factory]});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}
