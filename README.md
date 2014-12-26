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
