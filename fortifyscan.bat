@echo off

rem
rem Fortify SCA Scan Script. Tested on Fortify SCA 20.1.0, and Fortify SCA 19.2.0, running
rem on a Developer Command Prompt for VS 2019.
rem
rem Test run on Windows 2019 Server, 8 cores, 32 GB, general purpose SSD:
rem around 6 minutes 30 seconds, independent of SCA version.
rem

nuget restore

sourceanalyzer -verbose -b employeeapp-cs -clean
sourceanalyzer -verbose -b employeeapp-js -clean

sourceanalyzer -verbose -b employeeapp-cs @fortify-exclude-for-cs.txt msbuild /t:Rebuild
sourceanalyzer -verbose -b employeeapp-js @fortify-exclude-for-js.txt msbuild /t:Rebuild

echo --------------------------------------
echo FILES TRANSLATED FOR BACKEND (cs)
echo --------------------------------------
sourceanalyzer -verbose -b employeeapp-cs -show-files
echo --------------------------------------
echo FILES TRANSLATED FOR FRONTEND (js)
echo --------------------------------------
sourceanalyzer -verbose -b employeeapp-js -show-files

sourceanalyzer -verbose -b employeeapp-cs -scan -f employeeapp-cs.fpr
sourceanalyzer -verbose -b employeeapp-js -scan -f employeeapp-js.fpr
