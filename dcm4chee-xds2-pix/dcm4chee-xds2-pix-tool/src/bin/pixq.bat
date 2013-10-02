@echo off
rem -------------------------------------------------------------------------
rem PIX Query  Launcher
rem -------------------------------------------------------------------------

set DCM4CHE_VERSION=3.2.1
set XDS_VERSION=2.0.0

if not "%ECHO%" == ""  echo %ECHO%
if "%OS%" == "Windows_NT"  setlocal

set MAIN_CLASS=org.dcm4chee.xds2.pix.tool.PixQueryCmd
set MAIN_JAR=dcm4chee-xds2-pix-tool-%XDS_VERSION%.jar

set DIRNAME=.\
if "%OS%" == "Windows_NT" set DIRNAME=%~dp0%

rem Read all command line arguments

set ARGS=
:loop
if [%1] == [] goto end
        set ARGS=%ARGS% %1
        shift
        goto loop
:end

if not "%DCM4CHE_HOME%" == "" goto HAVE_DCM4CHE_HOME

set DCM4CHE_HOME=%DIRNAME%..

:HAVE_DCM4CHE_HOME

if not "%JAVA_HOME%" == "" goto HAVE_JAVA_HOME

set JAVA=java

goto SKIP_SET_JAVA_HOME

:HAVE_JAVA_HOME

set JAVA=%JAVA_HOME%\bin\java

:SKIP_SET_JAVA_HOME

set CP=%DCM4CHE_HOME%\conf\
set CP=%CP%;%DCM4CHE_HOME%\lib\%MAIN_JAR%
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4chee-xds2-pix-client-%XDS_VERSION%.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4chee-xds2-common-%XDS_VERSION%.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4che-net-audit-%DCM4CHE_VERSION%-SNAPSHOT.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4che-core-%DCM4CHE_VERSION%-SNAPSHOT.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4che-net-hl7-%DCM4CHE_VERSION%-SNAPSHOT.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4che-hl7-%DCM4CHE_VERSION%-SNAPSHOT.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4che-net-%DCM4CHE_VERSION%-SNAPSHOT.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\dcm4che-audit-%DCM4CHE_VERSION%-SNAPSHOT.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\slf4j-api-1.6.1.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\slf4j-log4j12-1.6.1.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\log4j-1.2.16.jar
set CP=%CP%;%DCM4CHE_HOME%\lib\commons-cli-1.2.jar

rem set "JAVA_OPTS=%JAVA_OPTS% -Djavax.net.debug=ssl,handshake,data,trustmanager,help"
set "JAVA_OPTS=%JAVA_OPTS% -Djavax.net.debug=ssl,handshake"
rem set "JAVA_OPTS=%JAVA_OPTS% -Djavax.net.debug=all"

"%JAVA%" %JAVA_OPTS% -cp "%CP%" %MAIN_CLASS% %ARGS%
