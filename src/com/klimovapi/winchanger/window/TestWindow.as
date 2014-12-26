/**
 * Created by Jack Klimov on 12/26/2014.
 * With passion and love
 */
package com.klimovapi.winchanger.window {
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.text.TextField;

public class TestWindow implements IWindow{
    private var _skin:Sprite;
    public function TestWindow() {

    }

    public function onCreate():void {
        _skin = new Sprite();
        _skin.graphics.beginFill(0x666666, 1);
        _skin.graphics.drawRect(0,0, 400, 800);
        _skin.graphics.endFill();
    }

    public function onShow():void {
        var textField:TextField = new TextField();
        textField.text = arguments[0];
        _skin.addChild(textField);
    }

    public function onResume():void {
    }

    public function onPause():void {
    }

    public function onDestroy():void {
    }

    public function getSkin():DisplayObjectContainer {
        return _skin;
    }
}
}
