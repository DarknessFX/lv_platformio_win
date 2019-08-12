@ECHO OFF
SETLOCAL ENABLEEXTENSIONS 
TITLE lv_platformio_win - Clean up temporary folders.
CD ..
CLS
ECHO **********************************************************************
ECHO CLEAN.CMD
ECHO   Removes temporary files from project, useful to reduce the folder 
ECHO size when backup/zip the project folder.
ECHO.

ECHO %cd%
ECHO.

REM Remove platformio temp files
IF EXIST ".platformio\.pio\build"   ( RMDIR /Q /S .platformio\.pio\build   )
IF EXIST ".platformio\.pio\libdeps" ( RMDIR /Q /S .platformio\.pio\libdeps )
REM IF EXIST ".platformio\.vscode"      ( RMDIR /Q /S .platformio\.vscode      )

REM Remove compiler/linker temp files
IF EXIST "tool\bin" ( RMDIR /Q /S tool\bin )

REM Confirm to remove InteliSense database
IF EXIST ".vscode\*.DB*" (
  ECHO ----------------------------------------------------------------------
  SET /P delInteliSenseDB=Delete VSCode InteliSense DBs? [Y/N]
)
IF /I "%delInteliSenseDB%" == "Y" ( DEL /Q ".platformio\.vscode\*.DB*" ".vscode\*.DB*" )

ECHO **********************************************************************
