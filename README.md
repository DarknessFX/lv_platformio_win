     .----------------.  .----------------.  .----------------. 
    | .--------------. || .--------------. || .--------------. |
    | |  ________    | || |  _________   | || |  ____  ____  | |
    | | |_   ___ `.  | || | |_   ___  |  | || | |_  _||_  _| | |
    | |   | |   `. \ | || |   | |_  \_|  | || |   \ \  / /   | |
    | |   | |    | | | || |   |  _|      | || |    > `' <    | |
    | |  _| |___.' / | || |  _| |_       | || |  _/ /'`\ \_  | |
    | | |________.'  | || | |_____|      | || | |____||____| | |
    | |              | || |              | || |              | |
    | '--------------' || '--------------' || '--------------' |
     '----------------'  '----------------'  '----------------' 

           DarknessFX @ https://dfx.lv | Twitter: @DrkFX

# VSCode Windows + PlatformIO + LittlevGL + SDL2 + CPPTools-win32 Extension + M5Stack/ESP32

VSCode Windows project template that allows develop C++ code for Windows (build, compile, debug) and deploy to M5Stack (or other ESP32) using PlatformIO (build, upload, monitor), this project can be useful to develop and test LittlevGL GUI on Windows PC before transfer to your M5Stack (or other ESP32).

This project is based on littlevgl/lv_platformio https://github.com/littlevgl/lv_platformio , adapted to be used with MSVC compiler/linker and to allow VSCode Windows to run both CPP Win Native and PlatformIO.

## Getting started

### Depends

- Windows:
VSCode - https://code.visualstudio.com/
C/C++ Extension and Compiler - https://code.visualstudio.com/docs/languages/cpp
PlatfomIO - https://docs.platformio.org/en/latest/ide/vscode.html
libSDL2 - https://www.libsdl.org/
libSDL2_Image - https://www.libsdl.org/projects/SDL_image/
LittlevGL Arduino - https://github.com/littlevgl/lv_arduino
LittlevGL Drivers - https://github.com/littlevgl/lv_drivers

- Arduino/ESP32 PlatformIO Libraries:
M5Stack - https://docs.platformio.org/en/latest/boards/espressif32/m5stack-core-esp32.html (ignore if using another ESP32 with another display).
LittlevGL Arduino - https://platformio.org/lib/show/6228/lv_arduino

### Prerequisites

```
VSCode - working.
C/C++ Extension - (run a basic sample to test) - build and compile working.
PlatformIO - (run a basic sample to test) - build, compile and upload working.

Basic stuff but if any of prerequisites are not working this project will not work either.
```

### Installing

Download this project and extract.
- Open /tool/build.cmd and change the CALL command to your local vcvarsall.bat path . (to where is your MSVC C++ compiler)
Download SDL2 Development Libraries @ SDL2-devel-2.0.10-VC.zip - https://www.libsdl.org/download-2.0.php and extract. 
- Copy the files /SDL2-2.0.10/include/* and /SDL2-2.0.10/lib/x64/* to ThisProjectFolder/lib/win/SDL2, all *.h + *.dll + *.lib will be inside the lib/win/SDL2 folder.
Download lv_arduino @ https://github.com/littlevgl/lv_arduino and extract.
- Copy the lvgl.h folder content to ThisProjectFolder/lvgl .
- Copy the /src folder to ThisProjectFolder/lvgl (ex: ThisProjectFolder/lvgl/src ) .
- Copy ThisProjectFolder/lv_drv_conf.h to ThisProjectFolder/lvgl/src/lv_drv_conf.h .
Make a new folder ThisProjectFolder/lvgl/src/lv_drivers .
Download lv_drivers @ https://github.com/littlevgl/lv_drivers and extract, copy the /display and /indev folders to ThisProjectFolder/lvgl/src/lv_drivers .

Change #include "lvgl/lvgl.h" to #include "../../../lvgl/lvgl.h" to fix header path in monitor.h , mouse.h , keyboard.h , mousewheel.h, win_drv.h and win_drv.c .
Edit ThisProjectFolder/lvgl/src/lc_drivers/display/monitor.c :
```
Line 371:     m->window = SDL_CreateWindow("TFT Simulator",
                              SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
                              MONITOR_HOR_RES * MONITOR_ZOOM, MONITOR_VER_RES * MONITOR_ZOOM, SDL_WINDOW_SHOWN);       /*last param. SDL_WINDOW_BORDERLESS to hide borders*/
 
Line 378:     m->renderer = SDL_CreateRenderer(m->window, -1, SDL_RENDERER_SOFTWARE);
```

If you're not using a M5Stack, then you will need to edit the /.platformio/platformio.ini and change to your ESP32 board configs.

<img src="https://github.com/DarknessFX/lv_platformio_win/blob/master/.git_img/folder_tree.png" />

### How to use

Always use the "lv_platformio_win.code-workspace" to open the project. 
Change your C/C++ Configuration between Win64 or PlatformIO in VSCode at down-right statusbar. <img src="https://github.com/DarknessFX/lv_platformio_win/blob/master/.git_img/change_config.png.png" />
Change your debug environment (if you have JTAG/debug tools) between Windows or PlatformIO Debug in VSCode at down-left statusbar. <img src="https://github.com/DarknessFX/lv_platformio_win/blob/master/.git_img/change_debug.png.png" />

### Features

You can use F5 to build+run the windows EXE, F10 and F11 to step through the code in windows debug mode. 
You can use the PlatformIO toolbar functions to build, upload, monitor as any other PlatformIO project.
This is a template that runs the same sample code from littlevgl/lv_platformio https://github.com/littlevgl/lv_platformio , after the project is running with your Win builds and ESP32 builds you can use this template to build your own code.

## FAQ

- Intelisense isn't working / Fixing VSCode Intelisense for both PlatformIO+CPP.

After successfully execute "PlatformIO: Build", open the ".platformIO/.vscode/c_cpp_properties.json", copy the IncludePath and BrowsePath node values to ".vscode/c_cpp_properties.json". Restart VSCode.
Make sure you're using the right configuration Win64 or PlatformIO in VSCode, check the VSCode bottom-right statusbar to see what is the current configuration.
<img src="https://github.com/DarknessFX/lv_platformio_win/blob/master/.git_img/change_config.png.png" />

- Folder errors, Cannot find files, Fail to compile C++?
VSCode sometimes use full paths to refence folders, you need to change the following files and fix folder path references:
  .vscode/c_cpp_properties.json (Win64 node, change IncludePath and CompilerPath to your local paths)
  lv_platformio_win.code-workspace  (delete the PATH node to autofix the references on next VSCode start)
  tool/build.cmd (change CALL command to your local vcvarsall.bat path)

- Why the .platformio folder and not keep the platformio.ini in project root folder?
Is a small hack that allows VSCode to run as C++ Project (build, debug, launch) while keeping all the PlatformIO features (compile, upload, monitor). 
PlatformIO is aggressive in overwriting and owning the VSCode project folder, this hack fix this behaviour.

- Fail to compile with TFT_eSPI error?
M5Stack have its own TFT_eSPI code, if you find errors or blank screen uploading your code you may need to remove TFT_eSPI library from PlatformIO folder (%UserProfile%\.platformio\lib\TFT_eSPI_?\) to avoid conflicts.

## Versioning

v1.0 - Released.

## License

@Copyleft all wrongs reserved. <br/><br/>
DarknessFX @ <a href="https://dfx.lv" target="_blank">https://dfx.lv</a> | Twitter: <a href="https://twitter.com/DrkFX" target="_blank">@DrkFX</a> <br/>https://github.com/DarknessFX/lv_platformio_win
