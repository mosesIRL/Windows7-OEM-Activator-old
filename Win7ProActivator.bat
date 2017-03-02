REM  https://github.com/mgiljum/Windows-7-Pro-Activator
@echo off
:InstallOrNot
cls
@echo off
mode con: cols=100 lines=35
type "%cd%\agreement.txt"
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
echo Installed edition of Windows 7: %EDITION%
echo.
echo.
echo Select license type:
echo.
echo 1) Install OEM MS Windows 7 License
echo 2) Install retail, volume or sticker product key
echo 3) Exit
echo.
set /P LICENSETYPE="Enter selection: "
if /i "%LICENSETYPE:~,1%" EQU "1" goto installoem
if /i "%LICENSETYPE:~,1%" EQU "2" goto installretail
if /i "%LICENSETYPE:~,1%" EQU "3" goto cancel
goto INSTALLOEM
REM Select MANUFACTURER
:INSTALLOEM
cls
@echo off
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
echo 11) Cancel
echo.
set /P MANUFACTURER="Enter selection: "
if /i "%MANUFACTURER:~,1%" EQU "11" ( 
	goto Install 
		) else (
			cmd /c "%cd%\installcert.bat"
)
REM Install retail product key
:INSTALLRETAIL
cls
set /P RETAILKEY="Enter retail/VLK or sticker key (WITH DASHES): "
cscript //B "%windir%\system32\slmgr.vbs" -ipk %retailkey%
cscript //B "%windir%\system32\slmgr.vbs" -ato
cmd /c "%cd%\retailcheckstatus.bat"