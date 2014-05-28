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


rmdir ..\ARM /s/q
rmdir ..\Debug /s/q
rmdir ..\Release /s/q

echo./*
echo. * Building libraries...
echo. */
echo.

call %VSVARS%
if %FOUND_VC%==1 (
    msbuild  ..\rtaudio.sln /p:Configuration="Debug" /p:Platform="Win32" /t:Clean,Build
    msbuild  ..\rtaudio.sln /p:Configuration="Release" /p:Platform="Win32" /t:Clean,Build
    msbuild  ..\rtaudio.sln /p:Configuration="Debug" /p:Platform="ARM" /t:Clean,Build
    msbuild  ..\rtaudio.sln /p:Configuration="Release" /p:Platform="ARM" /t:Clean,Build	
) else (
    echo Script error.
    goto ERROR
)

goto EOF

:ERROR
pause

:EOF