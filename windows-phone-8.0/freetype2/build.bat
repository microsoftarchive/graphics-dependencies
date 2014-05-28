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
) else if defined VS110COMNTOOLS (
    set VSTOOLS="%VS110COMNTOOLS%"
    set VC_VER=110
    set FOUND_VC=1
)

set VSTOOLS=%VSTOOLS:"=%
set "VSTOOLS=%VSTOOLS:\=/%"

set VSVARS="%VSTOOLS%vsvars32.bat"

if not defined VSVARS (
    echo Can't find VC2012 or VC2013 installed!
    goto ERROR
)

echo./*
echo. * Building freetype library...
echo. */
echo.

call %VSVARS%
if %FOUND_VC%==1 (
    msbuild  freetype.sln /t:Clean
    msbuild  freetype.sln /p:Configuration="Debug" /p:Platform="Win32" 
    msbuild  freetype.sln /p:Configuration="Release" /p:Platform="Win32" 
    msbuild  freetype.sln /p:Configuration="Debug" /p:Platform="ARM" 
    msbuild  freetype.sln /p:Configuration="Release" /p:Platform="ARM" 
) else (
    echo Script error.
    goto ERROR
)

xcopy ".\freetype-2.5.0.1\include" "..\prebuilt\include\freetype\" /iycqs


goto EOF

:ERROR
pause

:EOF
