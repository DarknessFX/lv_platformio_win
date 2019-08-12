@ECHO OFF
SETLOCAL ENABLEEXTENSIONS 
TITLE lv_platformio_win - Compiling and building script.
CLS

REM Set dev_env PATH
CALL  "D:\Program Files\Microsoft Visual Studio\2019\VC\Auxiliary\Build\vcvarsall.bat" x64

REM Prepare folders
IF NOT EXIST "tool\bin"   ( MKDIR "tool\bin"      )
IF EXIST "tool\bin\*.exe" ( DEL /Q "tool\bin\*.*" )

REM Compile C or CPP from main folder
SET compilerflags=/nologo /Ox /Zi /Gd /EHsc /std:c++latest /I inc /I lib/win/SDL2 /I lvgl /AWAIT /UTF-8 /w
SET linkerflags=/OUT:"tool\bin\%1.exe" /LIBPATH:"lib/win/SDL2" /LIBPATH:"lvgl" /PDB:"tool\bin\%1.pdb" /DEBUG:FULL /DYNAMICBASE "SDL2.lib" "SDL2main.lib" "kernel32.lib" "user32.lib" "gdi32.lib" "winspool.lib" "comdlg32.lib" "advapi32.lib" "shell32.lib" "ole32.lib" "oleaut32.lib" "uuid.lib" "odbc32.lib" "odbccp32.lib" /MACHINE:X64 /INCREMENTAL /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /ERRORREPORT:PROMPT /NOLOGO /TLBID:1 /MANIFEST /NXCOMPAT

REM LVWIN - Compile Windows CPP sources
SET LVWIN_SOURCE=
SET LVWIN_SOURCE=%LVWIN_SOURCE% "src_win/*.cpp"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "src_win/*.c"

REM LV - Compile LittlevGL sources
SET LVWIN_SOURCE=%LVWIN_SOURCE% "drivers/sdl2/driver.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_core/lv_disp.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_core/lv_group.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_core/lv_indev.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_core/lv_obj.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_core/lv_refr.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_core/lv_style.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_draw/lv_draw.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_draw/lv_draw_arc.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_draw/lv_draw_basic.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_draw/lv_draw_img.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_draw/lv_draw_label.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_draw/lv_draw_line.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_draw/lv_draw_rect.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_draw/lv_draw_triangle.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_draw/lv_img_cache.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_draw/lv_img_decoder.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/win_drv.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/display/fbdev.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/display/monitor.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/display/R61581.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/display/SHARP_MIP.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/display/SSD1963.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/display/ST7565.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/display/UC1610.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/indev/AD_touch.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/indev/evdev.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/indev/FT5406EE8.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/indev/keyboard.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/indev/libinput.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/indev/mouse.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/indev/mousewheel.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_drivers/indev/XPT2046.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_font/lv_font.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_font/lv_font_fmt_txt.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_font/lv_font_roboto_12.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_font/lv_font_roboto_16.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_font/lv_font_roboto_22.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_font/lv_font_roboto_28.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_font/lv_font_unscii_8.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_hal/lv_hal_disp.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_hal/lv_hal_indev.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_hal/lv_hal_tick.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_anim.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_area.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_async.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_circ.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_color.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_fs.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_gc.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_ll.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_log.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_math.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_mem.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_task.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_templ.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_txt.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_misc/lv_utils.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_arc.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_bar.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_btn.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_btnm.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_calendar.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_canvas.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_cb.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_chart.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_cont.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_ddlist.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_gauge.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_img.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_imgbtn.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_kb.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_label.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_led.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_line.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_list.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_lmeter.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_mbox.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_objx_templ.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_page.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_preload.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_roller.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_slider.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_spinbox.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_sw.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_ta.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_table.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_tabview.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_tileview.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_objx/lv_win.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_themes/lv_theme.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_themes/lv_theme_alien.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_themes/lv_theme_default.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_themes/lv_theme_material.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_themes/lv_theme_mono.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_themes/lv_theme_nemo.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_themes/lv_theme_night.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_themes/lv_theme_templ.c"
SET LVWIN_SOURCE=%LVWIN_SOURCE% "lvgl/src/lv_themes/lv_theme_zen.c"

CL.EXE %compilerflags% %LVWIN_SOURCE% /link %linkerflags%

REM Clean up tmp build files and copy SDL2 DLL to bin folder
IF EXIST "tool\bin\*.exe" (
  REM Remove compiler/linker temp files
  DEL /Q *.ilk *.obj *.pdb
  DEL /Q tool\bin\*.ilk tool\bin\*.obj

  REM Gather external libraries DLL
  COPY /Y lib\win\SDL2\*.dll tool\bin
)
ECHO **********************************************************************
