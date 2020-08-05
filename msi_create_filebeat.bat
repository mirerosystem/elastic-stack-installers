@echo off

if DEFINED  BEAT_VERSION (
  echo Base BEAT_VERSION : '%BEAT_VERSION%'
) else (
  echo BEAT_VERSION not set. Set to '7.7.2-SNAPSHOT'
  set BEAT_VERSION="7.7.2-SNAPSHOT"
)

pushd .
cd %~dp0%
dotnet run --project %~dp0src\installer\BeatPackageCompiler\BeatPackageCompiler.csproj -c Release --package="filebeat-oss-%BEAT_VERSION%-windows-x86"  --keep-temp-files --verbose
popd
