sET MANU=HPCompaq
SET EDITION=Professional
if exist "%~dp0Certs\%MANU%\%EDITION% B\OEM\OEM.xrm-ms" (echo License variant found) else (echo License variant not found.)