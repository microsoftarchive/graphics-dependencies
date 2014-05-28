@echo off

@echo off

echo./*
echo. * Check VC++ environment...
echo. */
echo.

set FOUND_VC=0

if defined VS120COMNTOOLS (
    set VSTOOLS="%VS120COMNTOOLS%"
    set VC_VER=120
    set FOUND_VC=1
) 

set VSTOOLS=%VSTOOLS:"=%
set "VSTOOLS=%VSTOOLS:\=/%"

set VSVARS="%VSTOOLS%vsvars32.bat"

if not defined VSVARS (
    echo Can't find VC2013 installed!
    goto ERROR
)

rmdir .\UA_redist /s/q
rmdir ..\ARM /s/q
rmdir ..\Debug /s/q
rmdir ..\Release /s/q

echo./*
echo. * Building libraries...
echo. */
echo.

call %VSVARS%
if %FOUND_VC%==1 (
    msbuild  ..\poco_UA.sln /p:Configuration="Debug" /p:Platform="Win32" /t:Clean,Build
    msbuild  ..\poco_UA.sln /p:Configuration="Release" /p:Platform="Win32" /t:Clean,Build
    msbuild  ..\poco_UA.sln /p:Configuration="Debug" /p:Platform="ARM" /t:Clean,Build
    msbuild  ..\poco_UA.sln /p:Configuration="Release" /p:Platform="ARM" /t:Clean,Build	
) else (
    echo Script error.
    goto ERROR
)

echo. * Copying include files...
xcopy "..\Foundation\include\Poco" ".\UA_redist\include\Poco" /iycqs
xcopy "..\Foundation\include\Poco" ".\UA_redist\include\Poco" /iycqs
xcopy "..\Crypto\include\Poco\Crypto" ".\UA_redist\include\Poco\Crypto" /iycqs
xcopy "..\Data\include\Poco\Data" ".\UA_redist\include\Poco\Data" /iycqs
xcopy "..\Net\include\Poco\Net" ".\UA_redist\include\Poco\Net" /iycqs
xcopy "..\XML\include\Poco\DOM" ".\UA_redist\include\Poco\DOM" /iycqs
xcopy "..\XML\include\Poco\SAX" ".\UA_redist\include\Poco\SAX" /iycqs
xcopy "..\XML\include\Poco\XML" ".\UA_redist\include\Poco\XML" /iycqs
xcopy "..\Util\include\Poco\Util" ".\UA_redist\include\Poco\Util" /iycqs
xcopy "..\Zip\include\Poco\Zip" ".\UA_redist\include\Poco\Zip" /iycqs
xcopy "..\LICENSE" ".\UA_redist\include" /iycq

goto EOF

:ERROR
pause

:EOF