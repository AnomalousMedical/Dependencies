::Configuration Settings
set GeneratorName=Visual Studio 14 Win64
set Platform=x64
set SrcFolder=src
set BuildFolder=Win64Build
set SolutionName=OpenAL.sln
set Variables=-D EXAMPLES=0 ^
-D MMDEVAPI=0 ^
-D UTILS=0 ^
-D WAVE=0 ^
-D WINMM=0 ^
-D ALSOFT_CONFIG=0

::Less likely to need to change these.
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath="%~dp0%SrcFolder%"

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

cmake -G "%GeneratorName%" %Variables% %SrcPath%

msbuild.exe "%SolutionName%" /property:Configuration=Debug;Platform=%Platform%
msbuild.exe "%SolutionName%" /property:Configuration=Release;Platform=%Platform%

cd %CurrentDirectory%