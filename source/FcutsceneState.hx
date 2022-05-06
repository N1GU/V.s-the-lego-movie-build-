package;
import flixel.FlxState;
import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import lime.app.Application;
import openfl.Assets;
import vlc.VlcBitmap;

class FcutsceneState extends MusicBeatState {
    override function create() {
        var vid = new MP4Handler();
        vid.playMP4(Paths.video('legosFtheHaters'), false, null, new TitleState(), false, false, false);    
        
    }
}