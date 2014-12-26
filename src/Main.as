package {

import com.klimovapi.winchanger.WinChanger;
import com.klimovapi.winchanger.window.TestWindow;

import flash.display.Sprite;
import flash.text.TextField;

public class Main extends Sprite {
    public function Main() {


        WinChanger.startOn(this);
        WinChanger.register("test", TestWindow);

        WinChanger.show("test", 1);
        WinChanger.show("test", 2);
        WinChanger.show("test", 3);

        trace("<== WinChanger BACK");
        WinChanger.back();
        trace("<== WinChanger BACK");
        WinChanger.back();
        trace("==> WinChanger NEXT");
        WinChanger.forward();

    }
}
}
