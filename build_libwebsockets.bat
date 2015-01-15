set ARGS=--DLWS_WITHOUT_TEST_SERVER:BOOL="1" -DLWS_WITHOUT_TEST_SERVER_EXTPOLL:BOOL="1" -DLWS_WITHOUT_TEST_FRAGGLE:BOOL="1" -DLWS_WITH_SSL:BOOL="0" -DLWS_WITHOUT_TEST_CLIENT:BOOL="1" -DCMAKE_CONFIGURATION_TYPES:STRING="Debug;Release;MinSizeRel;RelWithDebInfo" -DLWS_WITHOUT_TEST_PING:BOOL="1" -DLWS_WITHOUT_TESTAPPS:BOOL="1" 

cd libwebsockets
rm -rf bin
mkdir bin
cd bin
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
cd ..\..\..\..\
