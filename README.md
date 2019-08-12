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

This project is based on littlevgl/lv_platformio @ https://github.com/littlevgl/lv_platformio , adapted to be used with MSVC compiler/linker and to allow VSCode Windows to run both CPP Win Native and PlatformIO.

## Getting started

### Depends

Windows: <br/>
- VSCode - https://code.visualstudio.com/ <br/>
- C/C++ Extension and Compiler - https://code.visualstudio.com/docs/languages/cpp <br/>
- PlatfomIO - https://docs.platformio.org/en/latest/ide/vscode.html <br/>
- libSDL2 - https://www.libsdl.org/ <br/>
- libSDL2_Image - https://www.libsdl.org/projects/SDL_image/ <br/>
- LittlevGL Arduino - https://github.com/littlevgl/lv_arduino <br/>
- LittlevGL Drivers - https://github.com/littlevgl/lv_drivers <br/>

Arduino/ESP32 PlatformIO Libraries: <br/>
- M5Stack - https://docs.platformio.org/en/latest/boards/espressif32/m5stack-core-esp32.html (ignore if using ESP32 with another display).
- LittlevGL Arduino - https://platformio.org/lib/show/6228/lv_arduino

### Prerequisites

```
VSCode - working.
C/C++ Extension - (run a basic sample to test) - build and compile working.
PlatformIO - (run a basic sample to test) - build, compile and upload working.

Basic stuff but if any of prerequisites are not working this project will not work either.
```

### Installing

Download this project and extract. <br/>
Open `/tool/build.cmd` and change the `CALL` command to your local `vcvarsall.bat` path . (to where is your MSVC C++ compiler, ex: `C:\Program Files\Microsoft Visual Studio\2019\VC\Auxiliary\Build\vcvarsall.bat` ) <br/>
Download SDL2 Development Libraries @ SDL2-devel-2.0.10-VC.zip - https://www.libsdl.org/download-2.0.php and extract.  <br/>
Copy `/SDL2-2.0.10/include/*` and `/SDL2-2.0.10/lib/x64/*` files to `ThisProjectFolder/lib/win/SDL2`, all \*.h + \*.dll + \*.lib will be inside the `lib/win/SDL2 folder`. <br/>
Download lv_arduino @ https://github.com/littlevgl/lv_arduino and extract. <br/>
Copy `/src/src` folder to `ThisProjectFolder/lvgl` (ex: `ThisProjectFolder/lvgl/src` ) . <br/>
Copy `/src/lvgl.h` file to `ThisProjectFolder/lvgl/lvgl.h` . <br/>
Copy `ThisProjectFolder/lv_drv_conf.h` file to `ThisProjectFolder/lvgl/src/lv_drv_conf.h` . <br/>
Make a new folder `ThisProjectFolder/lvgl/src/lv_drivers` . <br/>
Download lv_drivers @ https://github.com/littlevgl/lv_drivers and extract.  . <br/>
Copy `/display` and `/indev` folders to `ThisProjectFolder/lvgl/src/lv_drivers` . <br/>
Copy `/win_drv.c` and `/win_drv.h` files to `ThisProjectFolder/lvgl/src/lv_drivers` . <br/>

<img src="https://github.com/DarknessFX/lv_platformio_win/blob/master/.git_img/folder_tree.png" />

Change ** second line of ** `#include "lvgl/lvgl.h"` to `#include "../../../lvgl/lvgl.h"` to fix header path in: <br/>
- `/lvgl/src/lv_drivers/win_drv.h` <br/>
- `/lvgl/src/lv_drivers/win_drv.c` <br/>
- `/lvgl/src/lv_drivers/display/monitor.h` <br/>
- `/lvgl/src/lv_drivers/indev/keyboard.h` <br/>
- `/lvgl/src/lv_drivers/indev/mouse.h` <br/>
- `/lvgl/src/lv_drivers/indev/mousewheel.h`

Edit `ThisProjectFolder/lvgl/src/lc_drivers/display/monitor.c` :
```
Line 371:     m->window = SDL_CreateWindow("TFT Simulator",
                              SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
                              MONITOR_HOR_RES * MONITOR_ZOOM, MONITOR_VER_RES * MONITOR_ZOOM, SDL_WINDOW_SHOWN);
 
Line 378:     m->renderer = SDL_CreateRenderer(m->window, -1, SDL_RENDERER_SOFTWARE);
```

If you're not using a M5Stack, then you will need to edit the `/.platformio/platformio.ini` and change to your ESP32 board configs.

### How to use

Always use the `"lv_platformio_win.code-workspace"` to open the project.  <br/>
Change your C/C++ Configuration between Win64 or PlatformIO in VSCode at down-right statusbar. <br/> <img src="https://github.com/DarknessFX/lv_platformio_win/blob/master/.git_img/change_config.png" /> <br/>
Change your debug environment (if you have JTAG/debug tools) between Windows or PlatformIO Debug in VSCode at down-left statusbar. <br/> <img src="https://github.com/DarknessFX/lv_platformio_win/blob/master/.git_img/change_debug.png" /> <br/>

### Features

You can use F5 to build+run the windows EXE, F10 and F11 to step through the code in windows debug mode.  <br/>
You can use the PlatformIO toolbar functions to build, upload, monitor as any other PlatformIO project. <br/>
This is a template that runs the same sample code from littlevgl/lv_platformio https://github.com/littlevgl/lv_platformio , after the project is running with your Win builds and ESP32 builds you can use this template to build your own code.

## FAQ

##### - Intelisense isn`t working / Fixing VSCode Intelisense for both PlatformIO+CPP. <br/>

After successfully execute "PlatformIO: Build", open the `".platformIO/.vscode/c_cpp_properties.json"`, copy the IncludePath and BrowsePath node values to `".vscode/c_cpp_properties.json"`. Restart VSCode. <br/>
Make sure you're using the right configuration Win64 or PlatformIO in VSCode, check the VSCode bottom-right statusbar to see what is the current configuration. <br/>
<img src="https://github.com/DarknessFX/lv_platformio_win/blob/master/.git_img/change_config.png" />

##### - PlatformIO does not support debugging error?

Open any source code file and change the VSCode Debug configuration to Windows. <br/>
<img src="https://github.com/DarknessFX/lv_platformio_win/blob/master/.git_img/change_debug.png" />

##### - fatal error C1083: Cannot open include file: 'lvgl/lvgl.h'

You need to change the ** second line of ** `#include "lvgl/lvgl.h"` to `#include "../../../lvgl/lvgl.h"`.

##### - Folder errors, Cannot find files, Fail to compile C++? <br/>
VSCode sometimes use full paths to refence folders, you need to change the following files and fix folder path references: <br/>
  `.vscode/c_cpp_properties.json` (Win64 node, change IncludePath and CompilerPath to your local paths). <br/>
  `lv_platformio_win.code-workspace`  (delete the PATH node to autofix the references on next VSCode start). <br/>
  `tool/build.cmd` (change CALL command to your local vcvarsall.bat path). <br/>

##### - Why the .platformio folder and not keep the platformio.ini in project root folder? <br/>
Is a small hack that allows VSCode to run as C++ Project (compile, debug, launch) while keeping all the PlatformIO features (build, upload, monitor).  <br/>
PlatformIO is aggressive in overwriting and owning the VSCode project folder, this hack fix this behaviour. <br/>

##### - Fail to compile with TFT_eSPI error? <br/>
M5Stack have its own TFT_eSPI code, if you find errors or blank screen uploading your code you may need to remove TFT_eSPI library from PlatformIO folder (`%UserProfile%\.platformio\lib\TFT_eSPI_?\`) to avoid conflicts. <br/>

## Versioning

v1.0 - Released.

## License

@Copyleft all wrongs reserved. <br/><br/>
DarknessFX @ <a href="https://dfx.lv" target="_blank">https://dfx.lv</a> | Twitter: <a href="https://twitter.com/DrkFX" target="_blank">@DrkFX</a> <br/>https://github.com/DarknessFX/lv_platformio_win
