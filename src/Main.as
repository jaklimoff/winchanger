package {

import com.klimovapi.winchanger.WinChanger;
import com.klimovapi.winchanger.window.IWindow;
import com.klimovapi.winchanger.window.TestWindow;

import flash.display.Sprite;
import flash.text.TextField;

[SWF(width=800, height=600)]
public class Main extends Sprite {
    public function Main() {
        var winChanger:WinChanger = new WinChanger();
        this.addChild(winChanger);

        winChanger.useHistory = true;

        winChanger.register("test", TestWindow);

        winChanger.show("test", 1);
        winChanger.show("test", 2);
        winChanger.show("test", 'test');



//        trace("<== WinChanger CLOSE");
//        winChanger.close();
//        trace("<== WinChanger BACK");
//        WinChanger.back();
//        trace("==> WinChanger NEXT");
//        WinChanger.forward();

    }
}
}
