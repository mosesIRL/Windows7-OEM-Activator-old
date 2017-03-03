REM **********************************************************************************
REM *  TO USE THIS SCRIPT, YOU MUST SELECT A MODE.                                   *
REM *                                                                                *
REM *  MODE=0 -> Standard Mode (fully interactive)                                   *
REM *  MODE=1 -> Unattended mode (fully unattended)                                  *
REM *  MODE=2 -> Auto Mode (Automatic, but you will get some prompts)                *
REM *  MODE=3 -> Retail Mode (Skip straight to retail/VL product key activation)     *
REM *                                                                                *
REM *  To change from Standard Mode, change the number 0 below to the mode you want  *
REM **********************************************************************************



SET MODE==0



REM ===================================================================================================================================

REM Don't change anything in here

IF %MODE%==0 (CALL %~dp0Activator\Win7_OEM_Activator.bat)
IF %MODE%==1 (CALL %~dp0Activator\Win7_OEM_Activator.bat UNATTEND)
IF %MODE%==2 (CALL %~dp0Activator\Win7_OEM_Activator.bat AUTO)
IF %MODE%==3 (CALL %~dp0Activator\Win7_OEM_Activator.bat RETAIL)


REM ===================================================================================================================================



REM *************************************************
REM *  Add anything you need to include in          *
REM *  SetupComplete.cmd below this box.            *
REM *************************************************

