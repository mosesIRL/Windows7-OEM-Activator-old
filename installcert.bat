@echo off
if "%~1"=="" (
	goto MATCHMANU
	) else (
		goto %~1
)
:MATCHMANU
if /i "%MANUFACTURER:~,1%" EQU "1" SET MANU=AcerGatewayPackard
if /i "%MANUFACTURER:~,1%" EQU "2" SET MANU=Alienware
if /i "%MANUFACTURER:~,1%" EQU "3" SET MANU=ASUS
if /i "%MANUFACTURER:~,1%" EQU "4" SET MANU=Dell
if /i "%MANUFACTURER:~,1%" EQU "5" SET MANU=Fujitsu
if /i "%MANUFACTURER:~,1%" EQU "6" SET MANU=HPCompaq
if /i "%MANUFACTURER:~,1%" EQU "7" SET MANU=LenovoIBM
if /i "%MANUFACTURER:~,1%" EQU "8" SET MANU=Samsung
if /i "%MANUFACTURER:~,1%" EQU "9" SET MANU=Sony
if /i "%MANUFACTURER:~,1%" EQU "10" SET MANU=Toshiba
echo Manufacturer selected: %MANU% >> %~dp0log.txt
:InstallA
for /f %%a in (%~dp0Certs\%MANU%\%EDITION% A\OEM\slp.cmd) do (set keya=%%a)
REM cscript //B "%windir%\system32\slmgr.vbs" -ilc "%~dp0Certs\%MANU%\%EDITION% A\OEM\OEM.xrm-ms"
echo Certificate A installed.
REM cscript //B "%windir%\system32\slmgr.vbs" -ipk %keya%
echo Product key A installed.
REM cscript //B "%windir%\system32\slmgr.vbs" -ato
echo Activation attempt A started.
call "%~dp0checkstatus.bat" CHECKOEM
exit /b
:InstallB
for /f %%a in (%~dp0Certs\%MANU%\%EDITION% B\OEM\slp.cmd) do (set keyb=%%a)
echo License activation failed. Attempting alternative certificate and product key...
REM cscript //B "%windir%\system32\slmgr.vbs" -ilc "%~dp0Certs\%MANU%\%EDITION% B\OEM\OEM.xrm-ms"
echo Certificate B installed. >> %~dp0log.txt
REM cscript //B "%windir%\system32\slmgr.vbs" -ipk %keyb%
echo Product key B installed. >> %~dp0log.txt
REM cscript //B "%windir%\system32\slmgr.vbs" -ato
echo Activation attempt B started. >> %~dp0log.txt
call "%~dp0checkstatus.bat" BVARIANTTEST
exit /b