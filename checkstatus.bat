REM @echo off
REM cls
goto %~1
echo.
echo.
echo License installed, checking activation status...
echo.
:RETAILCHECK
for /f "tokens=3 delims=: " %%a in (
    'cscript //nologo "%systemroot%\system32\slmgr.vbs" /dli ^| find "License Status:"' 
) do set "licenseStatus=%%a"

if /i "%licenseStatus%"=="Licensed" (
  echo Retailed key activation successful. >> %~dp0log.txt
  echo License activated successfully!
  goto ACTIVATIONCOMPLETE
) else (
  goto FAILEDRESTARTPROMPT )
:FAILEDRESTARTPROMPT
REM FAILEDRESTARTPROMPT
echo Retail license key activation failed. >> %~dp0log.txt
echo License activation failed. This may be due to a typo,
echo or the product key you entered doesn't match the
echo installed version.
echo.
set /P restartprompt="Start over? (Y/N) "
if /I "%restartprompt%" EQU "Y" call "%~dp0Win7ProActivator.bat"
if /I "%restartprompt%" EQU "N" goto ACTIVATIONCOMPLETE
:CHECKOEM
REM CHECKOEM
for /f "tokens=3 delims=: " %%a in (
    'cscript //nologo "%systemroot%\system32\slmgr.vbs" /dli ^| find "License Status:"' 
) do set "licenseStatus=%%a"

if /i "%licenseStatus%"=="Licensed" (
  echo License A activation check successful >> %~dp0log.txt
  echo License activated successfully!
  goto ACTIVATIONCOMPLETE
) else (
  goto TRYBVARIANT )
:TRYBVARIANT
REM TRYBVARIANT
echo License A activation check failed. >> %~dp0log.txt
if exist "%~dp0Certs\%MANU%\%EDITION% B\OEM\OEM.xrm-ms" (
echo License variant found. >>%~dp0log.txt
call "%~dp0installcert.bat" InstallB
	) else (
		echo License variant not found. >> %~dp0log.txt
		goto UNSUPPORTED
)
:BVARIANTTEST
REM BVARIANTTEST
for /f "tokens=3 delims=: " %%a in (
    'cscript //nologo "%systemroot%\system32\slmgr.vbs" /dli ^| find "License Status:"' 
) do set "licenseStatus=%%a"

if /i "%licenseStatus%"=="Licensed" (
  echo License B activation check successful. >>%~dp0log.txt
  echo License activated successfully!
  echo.
  echo Restart your computer to finalize the changes.
  goto ACTIVATIONCOMPLETE 
  ) else (
	echo License B activation check failed. Product not supported. >> %~dp0log.txt
	goto UNSUPPORTED
)
:UNSUPPORTED
REM UNSUPPORTED
echo License activation failed. This may be due to an
echo unspported image of Windows 7, or an unsupported make/model.
set /P TRYAGAIN="Start over? (Y/N) "
if /i TRYAGAIN=="y" call "%~dp0Win7ProActivator.bat"
if /i TRYAGAIN=="n" exit
:ACTIVATIONCOMPLETE
REM ACTIVATIONCOMPLETE
echo.
echo.
set /P RESTART="Restart the computer? (Y/N) "
if /i RESTART=="y" cmd /c "shutdown /f /r /t 0"
if /i RESTART=="n" exit /b