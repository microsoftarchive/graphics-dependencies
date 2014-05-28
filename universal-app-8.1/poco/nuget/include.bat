@echo off

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

