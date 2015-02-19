@echo off

pushd lpng1616
	if exist bin (
		rmdir /s /q bin
	)

	mkdir bin
	pushd bin
		mkdir WindowsPhone_8.0
		pushd WindowsPhone_8.0
		mkdir arm
		mkdir win32
		pushd arm
			cmake -G"Visual Studio 12 2013 ARM" -DCMAKE_SYSTEM_NAME=WindowsPhone -DCMAKE_SYSTEM_VERSION=8.0 -DZLIB_INCLUDE_DIR:PATH=..\zlib-1.2.8\bin\WindowsPhone_8.0\arm\ -DZLIB_LIBRARY:PATH=..\..\..\..\zlib-1.2.8\bin\WindowsPhone_8.0\arm\MinSizeRel\ ../../../
		popd
		pushd win32
			cmake -G"Visual Studio 12 2013" -DCMAKE_SYSTEM_NAME=WindowsPhone -DCMAKE_SYSTEM_VERSION=8.0 -DZLIB_INCLUDE_DIR:PATH=..\zlib-1.2.8\bin\WindowsPhone_8.0\win32\ -DZLIB_LIBRARY:PATH=..\..\..\..\zlib-1.2.8\bin\WindowsPhone_8.0\win32\MinSizeRel\ ../../../
		popd
	popd
	mkdir WindowsPhone_8.1
	pushd WindowsPhone_8.1
		mkdir arm
		mkdir win32
		pushd arm
			cmake -G"Visual Studio 12 2013 ARM" -DCMAKE_SYSTEM_NAME=WindowsPhone -DCMAKE_SYSTEM_VERSION=8.1 -DZLIB_INCLUDE_DIR:PATH=..\zlib-1.2.8\bin\WindowsPhone_8.1\arm\ -DZLIB_LIBRARY:PATH=..\..\..\..\zlib-1.2.8\bin\WindowsPhone_8.1\arm\MinSizeRel\ ../../../
		popd
		pushd win32
			cmake -G"Visual Studio 12 2013" -DCMAKE_SYSTEM_NAME=WindowsPhone -DCMAKE_SYSTEM_VERSION=8.1 -DZLIB_INCLUDE_DIR:PATH=..\zlib-1.2.8\bin\WindowsPhone_8.1\win32\ -DZLIB_LIBRARY:PATH=..\..\..\..\zlib-1.2.8\bin\WindowsPhone_8.1\win32\MinSizeRel\ ../../../
		popd
	popd
	mkdir WindowsStore_8.1
	pushd WindowsStore_8.1
		mkdir arm
		mkdir win32
			pushd arm
				cmake -G"Visual Studio 12 2013 ARM" -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=8.1 -DZLIB_INCLUDE_DIR:PATH=..\zlib-1.2.8\bin\WindowsStore_8.1\arm\ -DZLIB_LIBRARY:PATH=..\..\..\..\zlib-1.2.8\bin\WindowsStore_8.1\arm\MinSizeRel\ ../../../
			popd
			pushd win32
				cmake -G"Visual Studio 12 2013" -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=8.1 -DZLIB_INCLUDE_DIR:PATH=..\zlib-1.2.8\bin\WindowsStore_8.1\win32\ -DZLIB_LIBRARY:PATH=..\..\..\..\zlib-1.2.8\bin\WindowsStore_8.1\win32\MinSizeRel\ ../../../
			popd
		popd
	popd
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
msbuild  lpng1616\bin\WindowsPhone_8.0\win32\libpng.sln /p:Configuration="Release"  /p:Platform="Win32" /m
msbuild  lpng1616\bin\WindowsPhone_8.0\arm\libpng.sln /p:Configuration="Release"  /p:Platform="ARM" /m
msbuild  lpng1616\bin\WindowsPhone_8.1\win32\libpng.sln /p:Configuration="Release"  /p:Platform="Win32" /m
msbuild  lpng1616\bin\WindowsPhone_8.1\arm\libpng.sln /p:Configuration="Release"  /p:Platform="ARM" /m
msbuild  lpng1616\bin\WindowsStore_8.1\win32\libpng.sln /p:Configuration="Release"  /p:Platform="Win32" /m
msbuild  lpng1616\bin\WindowsStore_8.1\arm\libpng.sln /p:Configuration="Release"  /p:Platform="ARM" /m
) else (
    echo Script error.
    goto ERROR
)


goto EOF

:ERROR
pause

:EOF



goto EOF

:ERROR

:EOF

popd
