::Configuration Settings
set GeneratorName=Visual Studio 16
set Platform=x64
set SrcFolder=src
set BuildFolder=Win64Build
set SolutionName=OgreProcedural.sln

::Less likely to need to change these.
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath="%~dp0%SrcFolder%"

::Variables need to be set here
set Variables=-D OGRE_BUILD=%RootDependencyFolder%Ogre\WindowsBuild ^
-D OGRE_SOURCE=%RootDependencyFolder%Ogre\src ^
-D OGRE_SOURCE_DIR=%RootDependencyFolder%Ogre\src ^
-D OgreProcedural_BUILD_SAMPLES=false ^
-D OgreProcedural_STATIC=true

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

cmake -G "%GeneratorName%" -A %Platform% %Variables% %SrcPath%

msbuild.exe /m "%SolutionName%" /property:Configuration=Debug;Platform=%Platform%
msbuild.exe /m "%SolutionName%" /property:Configuration=Release;Platform=%Platform%

cd %CurrentDirectory%