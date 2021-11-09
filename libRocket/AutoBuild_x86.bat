::Configuration Settings
set GeneratorName=Visual Studio 17
set Platform=Win32
set SrcFolder=src\Build
set BuildFolder=WindowsBuild
set SolutionName=libRocket.sln

::Less likely to need to change these.
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath="%~dp0%SrcFolder%"

::Variables need to be set here
set Variables=-D BUILD_SHARED_LIBS=0 ^
-D FREETYPE_INCLUDE_DIR_ft2build=%RootDependencyFolder%OgreDeps\WindowsInstall\include ^
-D FREETYPE_INCLUDE_DIR_freetype2=%RootDependencyFolder%OgreDeps\WindowsInstall\include\freetype ^
-D FREETYPE_LIBRARY=%RootDependencyFolder%OgreDeps\WindowsInstall\lib\Release\freetype.lib

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

cmake -G "%GeneratorName%" -A %Platform% %Variables% %SrcPath%

msbuild.exe "%SolutionName%" /property:Configuration=Debug;Platform=%Platform%
msbuild.exe "%SolutionName%" /property:Configuration=Release;Platform=%Platform%

cd %CurrentDirectory%