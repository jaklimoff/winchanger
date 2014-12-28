UIWindows Changer
==========
Small AS3 OneClass Framework to work with UI Windows in flash application

  
  
It is pretty easy to use it:

    WinChanger.startOn(this); // At first we should set container for all windows
    WinChanger.register("test", TestWindow); // and then register our first window!

    WinChanger.show("test", 1); // Lets show TestWindow with some parameter
    WinChanger.show("test", 2); // and second...
    WinChanger.show("test", 3); // third..

    WinChanger.back(); // and then go back as in ur favourite browser
    WinChanger.forward(); // forward!


To make code more readable and window usage more clearly all Windows have their own lifecycle:

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
