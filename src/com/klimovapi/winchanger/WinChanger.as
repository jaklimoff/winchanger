/**
 * Created by Jack Klimov on 12/26/2014.
 * With passion and love
 */
package com.klimovapi.winchanger {

import com.klimovapi.winchanger.window.IWindow;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.utils.describeType;
import flash.utils.getQualifiedClassName;

public class WinChanger extends Sprite {
    private var _windowStage:DisplayObjectContainer;
    private var _registeredWindows:Object = {};
    private var _useHistory:Boolean = true;
    private var _currentWindow:IWindow;
    private var _windowsHistory:Vector.<IWindow> = new <IWindow>[];
    private var _transition:Function = defaultTransition;

    public function WinChanger() {
        _windowStage = this;
    }

    private function defaultTransition(newWin:IWindow, oldWin:IWindow):void {
        _windowStage.addChild(newWin.getSkin());
        if (oldWin)_windowStage.removeChild(oldWin.getSkin());
    }


    /**
     * Register the new window pattern to show!
     * @param winKey Window Key
     * @param winClass Window Class
     */
    public function register(winKey:String, winClass:Class):void {
        checkIfClassHasInterface(winClass);
        if (_registeredWindows.hasOwnProperty(winKey))
            delete _registeredWindows[winKey];

        _registeredWindows[winKey] = winClass;
    }


    private function checkIfClassHasInterface(cl:Class):void {
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
    public function show(winKey:String, ...rest):IWindow {
        var window:IWindow = create(winKey);

        _transition(window, _currentWindow);
        if (_useHistory) {
            _currentWindow && _currentWindow.onPause();
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
    private function create(winKey:String):IWindow {
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
    public function close():void {
        if (_currentWindow) {
            _windowStage.removeChild(_currentWindow.getSkin());
            _currentWindow.onDestroy();
            var winInd:Number = _windowsHistory.indexOf(_currentWindow);
            if (winInd > -1) {   // del from history
                _windowsHistory.splice(winInd, 1);
            }
            loadLastWindowFromHistory();
        }
    }

    private function loadLastWindowFromHistory():IWindow {
        if (_windowsHistory.length > 0) {
            var window:IWindow = _windowsHistory[_windowsHistory.length - 1];
            window.onResume();
            return window;
        }
        return null;
    }

    public function back():IWindow {
        var winInd:Number = _windowsHistory.indexOf(_currentWindow);
        if (winInd != 0 && _useHistory) {
            var oldWindow:IWindow = _currentWindow;
            _currentWindow = _windowsHistory[winInd - 1];
            oldWindow.onPause();
            _currentWindow.onResume();
            _transition(_currentWindow, oldWindow);
            return _currentWindow;
        }
        return null;
    }

    public function forward():IWindow {
        var winInd:Number = _windowsHistory.indexOf(_currentWindow);
        if (winInd < _windowsHistory.length - 1 && _useHistory) {
            var oldWindow:IWindow = _currentWindow;
            _currentWindow = _windowsHistory[winInd + 1];
            oldWindow.onPause();
            _currentWindow.onResume();
            _transition(_currentWindow, oldWindow);
            return _currentWindow;
        }
        return null;
    }

    /**
     * Dow you want to save all windows history?
     * @param value
     */
    public function set useHistory(value:Boolean):void {
        _useHistory = value;
    }

    /**
     * This is current active window on stage
     */
    public function get currentWindow():IWindow {
        return _currentWindow;
    }

    public function set transition(value:Function):void {
        _transition = value;
    }
}
}
