REM https://github.com/mgiljum/Windows-7-Pro-Activator
@echo off
CLS
:init
setlocal DisableDelayedExpansion
set cmdInvoke=1
set winSysFolder=System32
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"

if '%cmdInvoke%'=='1' goto InvokeCmd 

ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
goto ExecElevation

:InvokeCmd
ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
exit /b

:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
if exist %~dp0log.txt del /f /q %~dp0log.txt

REM **************************************************************************************************************************************

:CHECKWINVERSION
for /f "tokens=4-5 delims=. " %%i in ('ver') do set WINVERSION=%%i.%%j
if NOT "%version%" == "6.1" (
	echo.
	echo.
	echo.         You are currently running an unsupported version
	echo.         of Windows. This script only supports Windows 7.
	echo.         Sorry^^!
	echo.
	echo.         Press any key to exit...
	PAUSE > NUL
	exit /b
)

:GETCURRENTEDITION
cls
mode con: cols=100 lines=35
type "%~dp0lib\agreement.txt"
FOR /F "usebackq tokens=3-4* delims= " %%A IN (`reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "ProductName" 2^>nul`) DO (
	if "%%D"=="" (
    set EDITION=%%C %%D
		) else (
			set EDITION=%%C
	)
)
if "%EDITION%" == "Enterprise" (
    cls
	echo.
	echo.
	echo.         You are currently running Windows 7 Enterprise.
	echo.         Unfortunately, this script does not support this
	echo.         edition of Windows. Sorry^^!
	echo.
	echo.         Press any key to exit...
	PAUSE > NUL
	exit /b
)

:GETMANUFACTURER
for /f "usebackq tokens=2 delims==" %%A IN (`wmic csproduct get vendor /value`) DO SET VENDOR=%%A

:SELECTOPTION
cls
echo.
echo.
type "%~dp0lib\agreement.txt"
echo.
echo.
echo.   Installed edition of Windows 7: %EDITION% >> %~dp0log.txt
echo.   Installed edition of Windows 7: %EDITION%
echo.
echo.
echo.   Select license type:
echo.
echo.   1) Automatic Activation
echo.   2) Manual activation (select manufacturer and Windows edition)
echo.   3) Install retail, volume or sticker product key
echo.   4) Cancel/Exit
echo.
set /P LICENSETYPE="Enter selection: "
if /i "%LICENSETYPE:~,1%" EQU "1" call "%~dp0lib\installcert.bat" AUTOMATCHMANU
if /i "%LICENSETYPE:~,1%" EQU "2" goto manualinstall
if /i "%LICENSETYPE:~,1%" EQU "3" goto installretail
if /i "%LICENSETYPE:~,1%" EQU "4" exit /b
goto INSTALLOEM

:MANUALINSTALL
echo OEM installation selected. >> %~dp0log.txt
cls
type "%~dp0lib\headertitle.txt"
echo.
echo.
echo.   Select manufacturer:
echo.   1) Acer
echo.   2) Alienware
echo.   3) Asus
echo.   4) Dell
echo.   5) Fujitsu
echo.   6) HP
echo.   7) IBM/Lenovo
echo.   8) Samsung
echo.   9) Sony
echo.   10) Toshiba
echo.   11) Start Over
echo.
set /P MANUFACTURER="Enter selection: "
if /i "%MANUFACTURER:~,1%" EQU "11" ( 
	goto InstallOrNot
		) else (
			cmd /c "%~dp0lib\installcert.bat"
)
exit /b

:INSTALLRETAIL
echo Retail key installation selected.
cls
set /P RETAILKEY="Enter retail/VLK or sticker key (WITH DASHES): "
cscript //B "%windir%\system32\slmgr.vbs" -ipk %retailkey%
echo Retail key installation started. >> %~dp0log.txt
cscript //B "%windir%\system32\slmgr.vbs" -ato
echo Retail key activation started. >> %~dp0log.txt
cmd /c "%~dp0\lib/checkstatus.bat" RETAILCHECK
exit /b