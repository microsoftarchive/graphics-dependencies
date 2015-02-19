@echo off

if exist cocos2d-x-v3 (
	rmdir /s /q cocos2d-x-v3
)

echo Copying Windows Store 8.1 CURL+OpenSSL Win32 Release libs...
set outdir="winrt_8.1"
xcopy "curl\projects\proj.win8.1-universal\Release\libcurl.Windows\libcurl.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq
xcopy "curl\projects\proj.win8.1-universal\Release\libcurl.Windows\libcurl.lib" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq
xcopy "openssl\vsout\NT-Store-8.1-Dll-Unicode\Release\Win32\bin\libeay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq
xcopy "openssl\vsout\NT-Store-8.1-Dll-Unicode\Release\Win32\bin\ssleay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq

echo Copying Windows Store 8.1 CURL+OpenSSL ARM Release libs...
xcopy "curl\projects\proj.win8.1-universal\ARM\Release\libcurl.Windows\libcurl.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq
xcopy "curl\projects\proj.win8.1-universal\ARM\Release\libcurl.Windows\libcurl.lib" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq
xcopy "openssl\vsout\NT-Store-8.1-Dll-Unicode\Release\arm\bin\libeay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq
xcopy "openssl\vsout\NT-Store-8.1-Dll-Unicode\Release\arm\bin\ssleay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq

echo Copying Windows Store 8.1 CURL include files...
xcopy "curl\include\curl" "cocos2d-x-v3\curl\include\%outdir%\curl\" /iycq

echo Copying Windows Phone 8.1 CURL+OpenSSL Win32 Release libs...
set outdir="wp_8.1"
xcopy "curl\projects\proj.win8.1-universal\Release\libcurl.WindowsPhone\libcurl.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq
xcopy "curl\projects\proj.win8.1-universal\Release\libcurl.WindowsPhone\libcurl.lib" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq
xcopy "openssl\vsout\NT-Phone-8.1-Dll-Unicode\Release\Win32\bin\libeay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq
xcopy "openssl\vsout\NT-Phone-8.1-Dll-Unicode\Release\Win32\bin\ssleay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq

echo Copying Windows Phone 8.1 CURL+OpenSSL ARM Release libs...
xcopy "curl\projects\proj.win8.1-universal\ARM\Release\libcurl.WindowsPhone\libcurl.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq
xcopy "curl\projects\proj.win8.1-universal\ARM\Release\libcurl.WindowsPhone\libcurl.lib" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq
xcopy "openssl\vsout\NT-Phone-8.1-Dll-Unicode\Release\arm\bin\libeay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq
xcopy "openssl\vsout\NT-Phone-8.1-Dll-Unicode\Release\arm\bin\ssleay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq

echo Copying Windows Phone 8.1 CURL include files...
xcopy "curl\include\curl" "cocos2d-x-v3\curl\include\%outdir%\curl\" /iycq

echo Copying Windows Phone 8.0 CURL+OpenSSL Win32 Release libs...
set outdir="wp8"
xcopy "curl\projects\proj.win8.1-universal\Release\libcurl.WP8\libcurl.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq
xcopy "curl\projects\proj.win8.1-universal\Release\libcurl.WP8\libcurl.lib" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq
xcopy "openssl\vsout\NT-Phone-8.0-Dll-Unicode\Release\Win32\bin\libeay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq
xcopy "openssl\vsout\NT-Phone-8.0-Dll-Unicode\Release\Win32\bin\ssleay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\win32\" /iycq

echo Copying Windows Phone 8.0 CURL+OpenSSL ARM Release libs...
xcopy "curl\projects\proj.win8.1-universal\ARM\Release\libcurl.WP8\libcurl.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq
xcopy "curl\projects\proj.win8.1-universal\ARM\Release\libcurl.WP8\libcurl.lib" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq
xcopy "openssl\vsout\NT-Phone-8.0-Dll-Unicode\Release\arm\bin\libeay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq
xcopy "openssl\vsout\NT-Phone-8.0-Dll-Unicode\Release\arm\bin\ssleay32.dll" "cocos2d-x-v3\curl\prebuilt\%outdir%\arm\" /iycq

echo Copying Windows Phone 8.0 CURL include files...
xcopy "curl\include\curl" "cocos2d-x-v3\curl\include\%outdir%8\curl\" /iycq

echo Copying Windows Store 8.1 libwebsockets Win32 Release libs...
set outdir="winrt_8.1"
xcopy "libwebsockets\bin\WindowsStore_8.1\win32\bin\MinSizeRel\libwebsockets.dll" "cocos2d-x-v3\websockets\prebuilt\%outdir%\win32\" /iycq
xcopy "libwebsockets\bin\WindowsStore_8.1\win32\lib\MinSizeRel\libwebsockets.lib" "cocos2d-x-v3\websockets\prebuilt\%outdir%\win32\" /iycq

echo Copying Windows Store 8.1 libwebsockets ARM Release libs...
xcopy "libwebsockets\bin\WindowsStore_8.1\arm\bin\MinSizeRel\libwebsockets.dll" "cocos2d-x-v3\websockets\prebuilt\%outdir%\arm\" /iycq
xcopy "libwebsockets\bin\WindowsStore_8.1\arm\lib\MinSizeRel\libwebsockets.lib" "cocos2d-x-v3\websockets\prebuilt\%outdir%\arm\" /iycq

echo Copying Windows Store 8.1 libwebsockets include files...
xcopy "libwebsockets\win32port\win32helpers\getopt.h" "cocos2d-x-v3\websockets\include\%outdir%\win32helpers\" /iycq
xcopy "libwebsockets\win32port\win32helpers\gettimeofday.h" "cocos2d-x-v3\websockets\include\%outdir%\win32helpers\" /iycq
xcopy "libwebsockets\bin\WindowsStore_8.1\win32\lws_config.h" "cocos2d-x-v3\websockets\include\%outdir%\" /iycq
xcopy "libwebsockets\lib\libwebsockets.h" "cocos2d-x-v3\websockets\include\%outdir%\" /iycq
xcopy "libwebsockets\lib\private-libwebsockets.h" "cocos2d-x-v3\websockets\include\%outdir%\" /iycq

echo Copying Windows Phone 8.1 libwebsockets Win32 Release libs...
set outdir="wp_8.1"
xcopy "libwebsockets\bin\WindowsPhone_8.1\win32\bin\MinSizeRel\libwebsockets.dll" "cocos2d-x-v3\websockets\prebuilt\%outdir%\win32\" /iycq
xcopy "libwebsockets\bin\WindowsPhone_8.1\win32\lib\MinSizeRel\libwebsockets.lib" "cocos2d-x-v3\websockets\prebuilt\%outdir%\win32\" /iycq

echo Copying Windows Phone 8.1 libwebsockets ARM Release libs...
xcopy "libwebsockets\bin\WindowsPhone_8.1\arm\bin\MinSizeRel\libwebsockets.dll" "cocos2d-x-v3\websockets\prebuilt\%outdir%\arm\" /iycq
xcopy "libwebsockets\bin\WindowsPhone_8.1\arm\lib\MinSizeRel\libwebsockets.lib" "cocos2d-x-v3\websockets\prebuilt\%outdir%\arm\" /iycq

echo Copying Windows Phone 8.1 libwebsockets include files...
xcopy "libwebsockets\win32port\win32helpers\getopt.h" "cocos2d-x-v3\websockets\include\%outdir%\win32helpers\" /iycq
xcopy "libwebsockets\win32port\win32helpers\gettimeofday.h" "cocos2d-x-v3\websockets\include\%outdir%\win32helpers\" /iycq
xcopy "libwebsockets\bin\WindowsPhone_8.1\win32\lws_config.h" "cocos2d-x-v3\websockets\include\%outdir%\" /iycq
xcopy "libwebsockets\lib\libwebsockets.h" "cocos2d-x-v3\websockets\include\%outdir%\" /iycq
xcopy "libwebsockets\lib\private-libwebsockets.h" "cocos2d-x-v3\websockets\include\%outdir%\" /iycq

echo Copying Windows Phone 8.0 libwebsockets Win32 Release libs...
set outdir="wp8"
xcopy "libwebsockets\bin\WindowsPhone_8.0\win32\bin\MinSizeRel\libwebsockets.dll" "cocos2d-x-v3\websockets\prebuilt\%outdir%\win32\" /iycq
xcopy "libwebsockets\bin\WindowsPhone_8.0\win32\lib\MinSizeRel\libwebsockets.lib" "cocos2d-x-v3\websockets\prebuilt\%outdir%\win32\" /iycq

echo Copying Windows Phone 8.0 libwebsockets ARM Release libs...
xcopy "libwebsockets\bin\WindowsPhone_8.0\arm\bin\MinSizeRel\libwebsockets.dll" "cocos2d-x-v3\websockets\prebuilt\%outdir%\arm\" /iycq
xcopy "libwebsockets\bin\WindowsPhone_8.0\arm\lib\MinSizeRel\libwebsockets.lib" "cocos2d-x-v3\websockets\prebuilt\%outdir%\arm\" /iycq

echo Copying Windows Phone 8.0 libwebsockets include files...
xcopy "libwebsockets\win32port\win32helpers\getopt.h" "cocos2d-x-v3\websockets\include\%outdir%\win32helpers\" /iycq
xcopy "libwebsockets\win32port\win32helpers\gettimeofday.h" "cocos2d-x-v3\websockets\include\%outdir%\win32helpers\" /iycq
xcopy "libwebsockets\bin\WindowsPhone_8.0\win32\lws_config.h" "cocos2d-x-v3\websockets\include\%outdir%\" /iycq
xcopy "libwebsockets\lib\libwebsockets.h" "cocos2d-x-v3\websockets\include\%outdir%\" /iycq
xcopy "libwebsockets\lib\private-libwebsockets.h" "cocos2d-x-v3\websockets\include\%outdir%\" /iycq

:EOF