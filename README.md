UIWindows Changer
==========
Small AS3 OneClass Framework to work with UI Windows in flash application

  
  
It is pretty easy to use it:
```php
// at first we should create an instance of WinChanger
var winChanger:WinChanger = new WinChanger(); 
// and add to preferable displayObjectContainer
stage.addChild(winChanger);

// and now... lets register some new window. 
// we use String value as first argument
// (we will show this window then by this key)
// and Window Class with IWindow interface as second arg
winChanger.register("test", TestWindow);

// cool! Now we can show our first window!
// first arg is Key value from register function
// and all other args will be thown forward to 
// onShow() method as arguments
winChanger.show("test", 1);
// we can pass much more arguments!
winChanger.show("test", 'test', 1, [4,5]);
```
    


To make code more readable and window usage more clearly all Windows have their own lifecycle:
```php
/** When window created */
function onCreate():void;
/** When window show (it also can get some params in arguments field)  */
function onShow():void;
/** When we show paused window again */
function onResume():void;
/** When window has gone to history */
function onPause():void;
/** When we destroy window we call this method  */
function onDestroy():void;
```
