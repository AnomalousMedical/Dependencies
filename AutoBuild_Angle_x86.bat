::Location Info
set CurrentDirectory=%CD%

set ThisFolder=%~dp0angle-ms
set RootDependencyFolder=%ThisFolder%..\
cd %ThisFolder%\src

::Configuration Settings
set SolutionName=angle.sln
set Platform=Win32

msbuild.exe /m "%SolutionName%" /property:Configuration=Debug;Platform=%Platform%
msbuild.exe /m "%SolutionName%" /property:Configuration=Release;Platform=%Platform%

cd %CurrentDirectory%