/**
 * Created by Jack Klimov on 12/26/2014.
 * With passion and love
 */
package com.klimovapi.winchanger {

import com.klimovapi.winchanger.window.IWindow;

import flash.display.DisplayObjectContainer;
import flash.utils.describeType;
import flash.utils.getQualifiedClassName;

public class WinChanger {
    private static var _windowStage:DisplayObjectContainer;
    private static var _registeredWindows:Object = {};
    private static var _useHistory:Boolean = true;
    private static var _currentWindow:IWindow;
    private static var _windowsHistory:Vector.<IWindow> = new <IWindow>[];
    private static var _transition:Function = defaultTransition;

    private static function defaultTransition(newWin:IWindow, oldWin:IWindow):void {
        _windowStage.addChild(newWin.getSkin());
        if(oldWin)_windowStage.removeChild(oldWin.getSkin());
    }

    /**
     * Choose where you want to show all your windows
     * @param windowStage
     */
    public static function startOn(windowStage:DisplayObjectContainer):void {
        _windowStage = windowStage;
    }


    public static function register(winKey:String, winClass:Class):void {
        checkIfClassHasInterface(winClass);
        if (_registeredWindows.hasOwnProperty(winKey))
            delete _registeredWindows[winKey];

        _registeredWindows[winKey] = winClass;
    }


    private static function checkIfClassHasInterface(cl:Class):void {
        var classDescription:XML = describeType(cl);
        var type:String = getQualifiedClassName(IWindow);
        var xmlList:XMLList = classDescription.factory.implementsInterface.(@type == type);
        if (xmlList.length() == 0) {
            throw new Error("Class must implement IWindow interface");
        }
    }

    /**
     * Show window by window key
     * @param winKey Window key
     * @param rest additional arguments to pass into onShow() method
     * @return new IWindow
     */
    public static function show(winKey:String, ...rest):IWindow {
        var window:IWindow = create(winKey);

        _transition(window, _currentWindow);

        if(_useHistory){
            _currentWindow &&  _currentWindow.onPause();
            _windowsHistory.push(window);
        } else {
            _currentWindow && _currentWindow.onDestroy();
        }

        window.onShow.apply(null, rest);
        _currentWindow = window;
        return window;
    }

    /**
     * Create new window by window key
     * @param winKey Window key
     * @return
     */
    private static function create(winKey:String):IWindow {
        if (_registeredWindows.hasOwnProperty(winKey) && _registeredWindows[winKey] is Class) {
            var window:IWindow = new _registeredWindows[winKey]();
            window.onCreate();
            return window;
        }
        return null;
    }

    /**
     * Close Current Window
     * @return
     */
    public static function close():void {
        if(_currentWindow){
            _windowStage.removeChild(_currentWindow.getSkin());

            var winInd:Number = _windowsHistory.indexOf(_currentWindow);
            if(winInd > -1) {   // del from history
                _windowsHistory.splice(winInd, 1);
            }
            loadLastWindowFromHistory();
        }
    }

    private static function loadLastWindowFromHistory():IWindow {
        if(_windowsHistory.length > 0){
            var window:IWindow = _windowsHistory[_windowsHistory.length-1];
            window.onResume();
            return window;
        }
        return null;
    }

    public static function back():IWindow {
        var winInd:Number = _windowsHistory.indexOf(_currentWindow);
        if(winInd != 0){
            var oldWindow:IWindow = _currentWindow;
            _currentWindow = _windowsHistory[winInd - 1];
            oldWindow.onPause();
            _currentWindow.onResume();
            _transition(_currentWindow, oldWindow);
            return _currentWindow;
        }
        return null;
    }

    public static function forward():IWindow {
        var winInd:Number = _windowsHistory.indexOf(_currentWindow);
        if(winInd < _windowsHistory.length - 1){
            var oldWindow:IWindow = _currentWindow;
            _currentWindow = _windowsHistory[winInd + 1];
            oldWindow.onPause();
            _currentWindow.onResume();
            _transition(_currentWindow, oldWindow);
            return _currentWindow;
        }
        return null;
    }

    public static function set useHistory(value:Boolean):void {
        _useHistory = value;
    }

    public static function get currentWindow():IWindow {
        return _currentWindow;
    }
}
}
