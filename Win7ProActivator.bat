REM  https://github.com/mgiljum/Windows-7-Pro-Activator
REM @echo off
del /f %~dp0log.txt
:InstallOrNot
REM cls
REM mode con: cols=100 lines=35
type "%~dp0agreement.txt"
REM Detect if Windows 7?
REM Detect current edition
FOR /F "usebackq skip=2 tokens=1-5" %%A IN (`reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "ProductName" 2^>nul`) DO (
    set ValueName=%%A
    set ValueType=%%B
    set EDITION=%%E
)
echo.
echo.
REM Show current version and select license option
:SELECTOPTION
echo Installed edition of Windows 7: %EDITION% >> %~dp0log.txt
echo Installed edition of Windows 7: %EDITION%
echo.
echo.
echo Select license type:
echo.
echo 1) Install OEM MS Windows 7 License
echo 2) Install retail, volume or sticker product key
echo 3) Cancel/Exit
echo.
set /P LICENSETYPE="Enter selection: "
if /i "%LICENSETYPE:~,1%" EQU "1" goto installoem
if /i "%LICENSETYPE:~,1%" EQU "2" goto installretail
if /i "%LICENSETYPE:~,1%" EQU "3" exit /b
goto INSTALLOEM
REM Select MANUFACTURER
:INSTALLOEM
echo OEM installation selected. >> %~dp0log.txt
REM cls

echo.
echo Select MANUFACTURERfacturer:
echo 1) Acer
echo 2) Alienware
echo 3) Asus
echo 4) Dell
echo 5) Fujitsu
echo 6) HP
echo 7) IBM/Lenovo
echo 8) Samsung
echo 9) Sony
echo 10) Toshiba
echo 11) Start Over
echo.
set /P MANUFACTURER="Enter selection: "
if /i "%MANUFACTURER:~,1%" EQU "11" ( 
	goto InstallOrNot
		) else (
			cmd /c "%~dp0installcert.bat"
)
exit /b
REM Install retail product key
:INSTALLRETAIL
echo Retail key installation selected.
REM cls
set /P RETAILKEY="Enter retail/VLK or sticker key (WITH DASHES): "
cscript //B "%windir%\system32\slmgr.vbs" -ipk %retailkey%
echo Retail key installation started. >> %~dp0log.txt
cscript //B "%windir%\system32\slmgr.vbs" -ato
echo Retail key activation started. >> %~dp0log.txt
cmd /c "%~dp0checkstatus.bat" RETAILCHECK
exit /b