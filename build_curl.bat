@echo off

@echo off

cd openssl
if exist vsout (
	rmdir /s /q vsout
)
call ms\do_vsprojects.bat
cd ..\


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
echo. * Building openssl and libcurl...
echo. */
echo.


call %VSVARS%
if %FOUND_VC%==1 (
msbuild  openssl\vsout\NT-Phone-8.0-Dll-Unicode\NT-Phone-8.0-Dll-Unicode.vcxproj /p:Configuration="Release" /p:Platform="Win32" /m

msbuild  openssl\vsout\NT-Phone-8.0-Dll-Unicode\NT-Phone-8.0-Dll-Unicode.vcxproj /p:Configuration="Release" /p:Platform="ARM" /m

msbuild  openssl\vsout\NT-Phone-8.1-Dll-Unicode\NT-Phone-8.1-Dll-Unicode.vcxproj /p:Configuration="Release" /p:Platform="Win32" /m

msbuild  openssl\vsout\NT-Phone-8.1-Dll-Unicode\NT-Phone-8.1-Dll-Unicode.vcxproj /p:Configuration="Release" /p:Platform="ARM" /m

msbuild  openssl\vsout\NT-Store-8.1-Dll-Unicode\NT-Store-8.1-Dll-Unicode.vcxproj /p:Configuration="Release" /p:Platform="Win32" /m

msbuild  openssl\vsout\NT-Store-8.1-Dll-Unicode\NT-Store-8.1-Dll-Unicode.vcxproj /p:Configuration="Release" /p:Platform="ARM" /m

msbuild  curl\projects\proj.win8.1-universal\libcurl.sln /p:Configuration="Release" /p:Platform="Win32" /m

msbuild  curl\projects\proj.win8.1-universal\libcurl.sln /p:Configuration="Release" /p:Platform="ARM" /m


) else (
    echo Script error.
    goto ERROR
)



goto EOF

:ERROR
pause

:EOF