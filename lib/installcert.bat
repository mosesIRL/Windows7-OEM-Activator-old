@echo off
if "%~1"=="" (
	goto MATCHMANU
	) else (
		goto %~1
)
:VALIDATEVENDOR
FOR %%G IN ("Acer"
            "Gateway"
            "Packard"
            "Alienware"
            "ASUS"
            "Dell Inc."
            "Fujitsu"
            "HP"
            "Compaq"
            "Lenovo"
            "IBM"
            "Samsung"
            "Sony"
            "Toshiba") DO (
            IF /I "%vendor%"=="%%~G" GOTO AUTOMATCHMANU
)

:INVALIDVENDOR
type "%~dp0lib\agreement.txt"
echo Vendor reported as "%vendor%". This did not match a supported vendor. Use manual mode if this was reported in error. >>%~dp0log.txt
echo.
echo.   Your PC reported that it's manufacturer is "%VENDOR%".
echo.  
echo.   This was not recognized by the activator script.
echo.   If you believe this is an error, restart the script
echo.   and use the manual mode to select the vendor.
echo.
echo.
echo Press any key to exit...
pause >nul
exit /b

:AUTOMATCHMANU
if /i %VENDOR% EQU "Acer" DO SET MANU=AcerGatewayPackard
if /i %VENDOR% EQU "Gateway" DO SET MANU=AcerGatewayPackard
if /i %VENDOR% EQU "Packard" DO SET MANU=AcerGatewayPackard
if /i %VENDOR% EQU "Alienware" DO SET MANU=Alienware
if /i %VENDOR% EQU "ASUS" DO SET MANU=ASUS
if /i %VENDOR% EQU "Dell Inc." DO SET MANU=Dell
if /i %VENDOR% EQU "Fujitsu" DO SET MANU=Fujitsu
if /i %VENDOR% EQU "HP" DO SET MANU=HPCompaq
if /i %VENDOR% EQU "Compaq" DO SET MANU=HPCompaq
if /i %VENDOR% EQU "Lenovo" DO SET MANU=LenovoIBM
if /i %VENDOR% EQU "IBM" DO SET MANU=LenovoIBM
if /i %VENDOR% EQU "Samsung" DO SET MANU=Samsung
if /i %VENDOR% EQU "Sony" DO SET MANU=Sony
if /i %VENDOR% EQU "Toshiba" DO SET MANU=Toshiba
goto INSTALLA

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
echo Manufacturer selected: %MANU% >> %~dp0..\log.txt

:InstallA
for /f %%a in (%~dp0Certs\%MANU%\%EDITION% A\OEM\slp.cmd) do (set keya=%%a)
cscript //B "%windir%\system32\slmgr.vbs" -ilc "%~dp0Certs\%MANU%\%EDITION% A\OEM\OEM.xrm-ms"
echo Certificate A installed.
cscript //B "%windir%\system32\slmgr.vbs" -ipk %keya%
echo Product key A installed.
cscript //B "%windir%\system32\slmgr.vbs" -ato
echo Activation attempt A started.
call "%~dp0checkstatus.bat" CHECKOEM
exit /b

:InstallB
for /f %%a in (%~dp0Certs\%MANU%\%EDITION% B\OEM\slp.cmd) do (set keyb=%%a)
echo License activation failed. Attempting alternative certificate and product key...
cscript //B "%windir%\system32\slmgr.vbs" -ilc "%~dp0Certs\%MANU%\%EDITION% B\OEM\OEM.xrm-ms"
echo Certificate B installed. >> %~dp0..\log.txt
cscript //B "%windir%\system32\slmgr.vbs" -ipk %keyb%
echo Product key B installed. >> %~dp0..\log.txt
cscript //B "%windir%\system32\slmgr.vbs" -ato
echo Activation attempt B started. >> %~dp0..\log.txt
call "%~dp0checkstatus.bat" BVARIANTTEST
exit /b