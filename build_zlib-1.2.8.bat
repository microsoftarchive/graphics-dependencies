@echo off
set ARGS=""

pushd zlib-1.2.8
rm -rf bin
mkdir bin
cd bin
mkdir WindowsPhone_8.0
cd WindowsPhone_8.0
mkdir arm
mkdir win32
cd arm
cmake -G"Visual Studio 11 2012 ARM" -DCMAKE_SYSTEM_NAME=WindowsPhone -DCMAKE_SYSTEM_VERSION=8.0 %ARGS% ../../../
cd ..\
cd win32
cmake -G"Visual Studio 11 2012" -DCMAKE_SYSTEM_NAME=WindowsPhone -DCMAKE_SYSTEM_VERSION=8.0  %ARGS%  ../../../
cd ..\..\
mkdir WindowsPhone_8.1
cd WindowsPhone_8.1
mkdir arm
mkdir win32
cd arm
cmake -G"Visual Studio 12 2013 ARM" -DCMAKE_SYSTEM_NAME=WindowsPhone -DCMAKE_SYSTEM_VERSION=8.1 %ARGS% ../../../
cd ..\
cd win32
cmake -G"Visual Studio 12 2013" -DCMAKE_SYSTEM_NAME=WindowsPhone -DCMAKE_SYSTEM_VERSION=8.1  %ARGS%  ../../../
cd ..\..\
mkdir WindowsStore_8.1
cd WindowsStore_8.1
mkdir arm
mkdir win32
cd arm
cmake -G"Visual Studio 12 2013 ARM" -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=8.1  %ARGS% ../../../
cd ..\
cd win32
cmake -G"Visual Studio 12 2013" -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=8.1  %ARGS%  ../../../
popd


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
echo. * Building zlib...
echo. */
echo.


call %VSVARS%
if %FOUND_VC%==1 (
msbuild  zlib-1.2.8\bin\WindowsPhone_8.0\win32\zlib.sln /p:Configuration="MinSizeRel"  /p:Platform="Win32"
msbuild  zlib-1.2.8\bin\WindowsPhone_8.0\arm\zlib.sln /p:Configuration="MinSizeRel"  /p:Platform="ARM"
msbuild  zlib-1.2.8\bin\WindowsPhone_8.1\win32\zlib.sln /p:Configuration="MinSizeRel"  /p:Platform="Win32"
msbuild  zlib-1.2.8\bin\WindowsPhone_8.1\arm\zlib.sln /p:Configuration="MinSizeRel"  /p:Platform="ARM"
msbuild  zlib-1.2.8\bin\WindowsStore_8.1\win32\zlib.sln /p:Configuration="MinSizeRel"  /p:Platform="Win32"
msbuild  zlib-1.2.8\bin\WindowsStore_8.1\arm\zlib.sln /p:Configuration="MinSizeRel"  /p:Platform="ARM"
) else (
    echo Script error.
    goto ERROR
)


goto EOF

:ERROR
pause

:EOF
