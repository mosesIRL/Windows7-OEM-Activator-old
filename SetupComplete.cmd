@echo off
REM *************************************************
REM *  The line below calls up the OEM Activator.   *
REM *  The FOGService is disabled at the beginning  *
REM *  of the script and is turned back on after    *
REM *  it has finished.                             *
REM *************************************************

cmd /c %~dp0Activator\Win7_OEM_Activator.bat

REM *************************************************
REM *  Add anything you need to include in          *
REM *  SetupComplete.cmd below this box.            *
REM *************************************************