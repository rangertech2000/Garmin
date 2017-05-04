using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class WordFactory extends Ui.PickerFactory {
    var mWords = ["Narb","Meri","Over","Wiss"];
    var mStation = ["Narberth","Merion","Overbrook","Wissahickon"];
    var mFont= Gfx.FONT_MEDIUM;
    
    function initialize() {
        PickerFactory.initialize();
        }
/*
    function initialize(words, options) {
        PickerFactory.initialize();

        mWords = words;

        if(options != null) {
            mFont = options.get(:font);
        }

        if(mFont == null) {
            mFont = Gfx.FONT_LARGE;
        }
    }
*/
/*    function getIndex(value) {
        if(value instanceof String) {
            for(var i = 0; i < mWords.size(); ++i) {
                if(value.equals(Ui.loadResource(mWords[i]))) {
                    return i;
                }
            }
        }
        else {
            for(var i = 0; i < mWords.size(); ++i) {
                if(mWords[i].equals(value)) {
                    return i;
                }
            }
        }

        return 0;
    }
*/
<<<<<<< Upstream, based on branch 'feature1' of https://github.com/rangertech2000/Garmin.git
 	function getIndex(value) {
        var index = mWords.find(value);
        return index;
    }
    
=======
>>>>>>> 6370fff v.b.0.7.2
    function getSize() {
        return mWords.size();
    }

    function getValue(index) {
        return mStation[index];
    }

    function getDrawable(index, selected) {
        return new Ui.Text({:text=>mWords[index], :color=>Gfx.COLOR_WHITE, :font=>mFont, :locX=>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER});
    }
}
