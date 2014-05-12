@echo off

cd .\zlib
call .\build.bat
cd ..\libjpeg
call .\build.bat
cd ..\libpng
call .\build.bat
cd ..\libtiff
call .\build.bat
cd ..\freetype2
call .\build.bat
cd ..\