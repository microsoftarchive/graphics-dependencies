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


echo./*
echo. * Building Chipmunk...
echo. */
echo.


call %VSVARS%
if %FOUND_VC%==1 (

msbuild  Chipmunk2D\msvc\vc13\chipmunk\universal-app\chipmunk.sln /p:Configuration="Release" /p:Platform="Win32" /t:Clean
msbuild  Chipmunk2D\msvc\vc13\chipmunk\universal-app\chipmunk.sln /p:Configuration="Release" /p:Platform="Win32"

msbuild  Chipmunk2D\msvc\vc13\chipmunk\universal-app\chipmunk.sln /p:Configuration="Release" /p:Platform=ARM" /t:Clean
msbuild  Chipmunk2D\msvc\vc13\chipmunk\universal-app\chipmunk.sln /p:Configuration="Release" /p:Platform="ARM"


) else (
    echo Script error.
    goto ERROR
)



goto EOF

:ERROR
pause

:EOF