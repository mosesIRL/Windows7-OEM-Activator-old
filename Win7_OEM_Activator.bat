REM https://github.com/mgiljum/Windows-7-Pro-Activator
reM CLS
reM :init
reM setlocal DisableDelayedExpansion
reM set cmdInvoke=1
reM set winSysFolder=System32
reM set "batchPath=%~0"
reM for %%k in (%0) do set batchName=%%~nk
reM set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
reM setlocal EnableDelayedExpansion
reM 
reM :checkPrivileges
reM NET FILE 1>NUL 2>NUL
reM if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )
reM 
reM :getPrivileges
reM if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
reM ECHO.
reM ECHO **************************************
reM ECHO Invoking UAC for Privilege Escalation
reM ECHO **************************************
reM 
reM ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
reM ECHO args = "ELEV " >> "%vbsGetPrivileges%"
reM ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
reM ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
reM ECHO Next >> "%vbsGetPrivileges%"
reM 
reM if '%cmdInvoke%'=='1' goto InvokeCmd 
reM 
reM ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
reM goto ExecElevation
reM 
reM :InvokeCmd
reM ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
reM ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"
reM 
reM :ExecElevation
reM "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
reM exit
reM 
reM :gotPrivileges
reM setlocal & cd /d %~dp0
reM if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
reM if exist %~dp0log.txt del /f /q %~dp0log.txt

REM **************************************************************************************************************************************

REM :CHECKWINVERSION
REM for /f "tokens=4-5 delims=. " %%i in ('ver') do set WINVERSION=%%i.%%j
REM if NOT "%version%" == "6.1" (
REM 	echo.
REM 	echo.
REM 	echo.         You are currently running an unsupported version
REM 	echo.         of Windows. This script only supports Windows 7.
REM 	echo.         Sorry^^!
REM 	echo.
REM 	echo.         Press any key to exit...
REM 	PAUSE > NUL
REM 	exit /b
REM )

:GETCURRENTEDITION
REM cls
REM mode con: cols=100 lines=35
type "%~dp0lib\agreement.txt"
FOR /F "usebackq tokens=3-4* delims= " %%A IN (`reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "ProductName" 2^>nul`) DO (
	if "%%D"=="" (
    set EDITION=%%C %%D
		) else (
			set EDITION=%%C
	)
)
if "%EDITION%" == "Enterprise" (
    REM cls
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
if "%~1"=="auto" (
	call "%~dp0lib\installcert.bat" VALIDATEVENDOR
	exit /b
)
if "%~1"=="retail" (
	goto INSTALLRETAIL
)
if "%~1"=="manual" (
	goto manualinstall
)

:SELECTOPTION
REM cls
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
if /i "%LICENSETYPE:~,1%" EQU "1" call "%~dp0lib\installcert.bat" VALIDATEVENDOR
exit
if /i "%LICENSETYPE:~,1%" EQU "2" goto manualinstall
exit
if /i "%LICENSETYPE:~,1%" EQU "3" goto installretail
exit
if /i "%LICENSETYPE:~,1%" EQU "4" exit /b
goto MANUALINSTALL

:MANUALINSTALL
echo OEM installation selected. >> %~dp0log.txt
REM cls
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