@echo off
rem set DOTNET_CLI_TELEMETRY_OPTOUT=1

rem When built with Release Manager we put 
rem Net Core SDK in the parent dir
rem set PATH=%PATH%;%~dp0..\dotnet-sdk;
if DEFINED  BEAT_VERSION (
  echo BEAT_VERSION is '%BEAT_VERSION%'
) else (
  echo BEAT_VERSION not set. Set to '7.7.2-SNAPSHOT'
  set BEAT_VERSION="7.7.2-SNAPSHOT"
)

pushd .
cd %~dp0%
dotnet run --project %~dp0src\installer\BeatPackageCompiler\BeatPackageCompiler.csproj -c Release --package="filebeat-oss-%BEAT_VERSION%-windows-x86"  --keep-temp-files --verbose
popd
