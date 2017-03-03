cls
goto %~1
:RETAILCHECK
echo.
echo.
echo License installed, checking activation status...
echo.
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
echo Retail license key activation failed. >> %~dp0log.txt
echo License activation failed. This may be due to a typo,
echo or the product key you entered doesn't match the
echo installed version.
echo.
set /P restartprompt="Start over? (Y/N) "
if /I "%restartprompt%" EQU "Y" call "%~dp0Win7_OEM_Activator.bat"
if /I "%restartprompt%" EQU "N" goto ACTIVATIONCOMPLETE

:CHECKOEM
type "%~dp0lib\headertitle.txt"
echo.
echo.
echo License installed, checking activation status...
echo.
for /f "tokens=3 delims=: " %%a in (
    'cscript //nologo "%systemroot%\system32\slmgr.vbs" /dli ^| find "License Status:"' 
) do set "licenseStatus=%%a"

if /i "%licenseStatus%"=="Licensed" (
  echo License A activation check successful >> %~dp0log.txt
  type "%~dp0lib\headertitle.txt"
  echo.
  echo.
  echo.   License activated successfully!
  goto ACTIVATIONCOMPLETE
) else (
  goto TRYBVARIANT )
  
:TRYBVARIANT
echo License A activation check failed. >> %~dp0log.txt
if exist "%~dp0Certs\%MANU%\%EDITION% B\OEM\OEM.xrm-ms" (
echo License variant found. >>%~dp0log.txt
call "%~dp0lib\installcert.bat" InstallB
	) else (
		echo License variant not found. >> %~dp0log.txt
		goto UNSUPPORTED
)
:BVARIANTTEST
type "%~dp0lib\headertitle.txt"
echo.
echo.
echo Alternate license installed, checking activation status...
echo.
for /f "tokens=3 delims=: " %%a in (
    'cscript //nologo "%systemroot%\system32\slmgr.vbs" /dli ^| find "License Status:"' 
) do set "licenseStatus=%%a"

if /i "%licenseStatus%"=="Licensed" (
  type "%~dp0lib\headertitle.txt"
  echo.
  echo.
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
type "%~dp0lib\headertitle.txt"
echo.
echo.
echo.   License activation failed. This may be due to an
echo.   unspported image of Windows 7, or an unsupported make/model.
set /P TRYAGAIN="Start over? (Y/N) "
if /i TRYAGAIN=="y" call "%~dp0Win7_OEM_Activator.bat"
if /i TRYAGAIN=="n" exit

:ACTIVATIONCOMPLETE
echo.
echo.
set /P RESTART="Restart the computer? (Y/N) "
if /i RESTART=="y" "shutdown /f /r /t 0"
if /i RESTART=="n" exit /b