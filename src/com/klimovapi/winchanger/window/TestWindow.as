/**
 * Created by Jack Klimov on 12/26/2014.
 * With passion and love
 */
package com.klimovapi.winchanger.window {
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class TestWindow implements IWindow{
    private var _skin:Sprite;
    private var _args:Array;
    private const WIDTH:Number = 800;
    private const HEIGHT:Number = 600;
    public function TestWindow() {

    }

    public function onCreate():void {
        trace("TestWindow onCreate()");
        _skin = new Sprite();
        _skin.graphics.beginFill(0x607D8B, 1);
        _skin.graphics.drawRect(0,0, WIDTH, HEIGHT);
        _skin.graphics.endFill();
    }

    public function onShow():void {
        _args = arguments;
        trace("TestWindow[" + _args + "] onShow()");
        var tf:TextField = new TextField();
        tf.mouseEnabled = false;
        tf.text = arguments[0];
        tf.autoSize = TextFieldAutoSize.RIGHT;

        var tFormat:TextFormat = new TextFormat();
            tFormat.size = 150;
            tFormat.color = 0x455A64;
        tf.setTextFormat(tFormat);

        tf.x = WIDTH / 2 - tf.width / 2;
        tf.y = HEIGHT / 2 - tf.height / 2;

        _skin.addChild(tf);
    }

    public function onResume():void {
        trace("TestWindow[" + _args + "] onResume()");
    }

    public function onPause():void {
        trace("TestWindow[" + _args + "] onPause()");
    }

    public function onDestroy():void {
        trace("TestWindow[" + _args + "] onDestroy()");
    }

    public function getSkin():DisplayObjectContainer {
        return _skin;
    }
}
}
