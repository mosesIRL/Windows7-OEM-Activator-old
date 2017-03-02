REM MANUPRO
@echo off
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
:InstallA
cscript //B "%windir%\system32\slmgr.vbs" -ilc "C:\Certs\%MANU%\OEM\%EDITION% A\OEM\OEM.xrm-ms"
cscript //B "%windir%\system32\slmgr.vbs" -ipk YKHFT-KW986-GK4PY-FDWYH-7TP9F
cscript //B "%windir%\system32\slmgr.vbs" -ato
del C:\Certs /Q
call checkstatus.bat
:InstallB
echo License activation failed. Attempting alternative certificate and product key...
cscript //B "%windir%\system32\slmgr.vbs" -ilc "C:\Certs\%MANU%\OEM\%EDITION% B\OEM\OEM.xrm-ms"
cscript //B "%windir%\system32\slmgr.vbs" -ipk YKHFT-KW986-GK4PY-FDWYH-7TP9F
cscript //B "%windir%\system32\slmgr.vbs" -ato
call checkstatus.bat %