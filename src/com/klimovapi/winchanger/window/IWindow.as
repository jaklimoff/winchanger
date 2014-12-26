/**
 * Created by Jack Klimov on 12/26/2014.
 * With passion and love
 */
package com.klimovapi.winchanger.window {
import flash.display.DisplayObjectContainer;

public interface IWindow {
    function onCreate():void;
    function onShow():void;
    function onResume():void;
    function onPause():void;
    function onDestroy():void;
    function getSkin():DisplayObjectContainer;
}
}
