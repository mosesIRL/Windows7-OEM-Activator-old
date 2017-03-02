:CHECKSTATUS
cls
@echo off
echo.
echo.
echo License installed, checking activation status...
echo.
:RETAILCHECK
@echo off
for /f "tokens=3 delims=: " %%a in (
    'cscript //nologo "%systemroot%\system32\slmgr.vbs" /dli ^| find "License Status:"' 
) do set "licenseStatus=%%a"

if /i "%licenseStatus%"=="Licensed" (
  echo License activated successfully!
  goto activationsuccess
) else (
  goto FAILEDRESTARTPROMPT )
:FAILEDRESTARTPROMPT
echo License activation failed. This may be due to a typo,
echo or the product key you entered doesn't match the
echo installed version.
echo.
set /P restartprompt="Start over? (Y/N) "
if /I "%restartprompt%" EQU "Y" call "%cd%\Win7ProActivator.bat"
if /I "%restartprompt%" EQU "N" goto ACTIVATIONCOMPLETE
:OEMCHECK
@echo off
for /f "tokens=3 delims=: " %%a in (
    'cscript //nologo "%systemroot%\system32\slmgr.vbs" /dli ^| find "License Status:"' 
) do set "licenseStatus=%%a"

if /i "%licenseStatus%"=="Licensed" (
  echo License activated successfully!
  goto ACTIVATIONCOMPLETE
) else (
  goto TRYBVARIANT )
:TRYBVARIANT
if exist "C:\Certs\%MANU%\OEM\%EDITION% B\OEM\OEM.xrm-ms" (
call "%cd%\installcert.bat" %InstallB%
	) else (
		goto UNSUPPORTED
)
:BVARIANTTEST
@echo off
for /f "tokens=3 delims=: " %%a in (
    'cscript //nologo "%systemroot%\system32\slmgr.vbs" /dli ^| find "License Status:"' 
) do set "licenseStatus=%%a"

if /i "%licenseStatus%"=="Licensed" (
  echo License activated successfully!
  goto ACTIVATIONCOMPLETE 
  ) else (
	goto UNSUPPORTED
)
:UNSUPPORTED
cls
echo License activation failed. This may be due to an
echo unspported image of Windows 7, or an unsupported make/model.
set /P TRYAGAIN="Start over? (Y/N) "
if /i TRYAGAIN=="y" call "%cd%\Win7ProActivator.bat"
if /i TRYAGAIN=="n" goto ACTIVATIONCOMPLETE
:ACTIVATIONCOMPLETE
echo.
echo.
echo Press any key to exit...
pause > nul
cls
:CANCEL
exit /b