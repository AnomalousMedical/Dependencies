::Configuration Settings
set GeneratorName=Visual Studio 14 Win64
set Platform=x64
set SrcFolder=src
set BuildFolder=Win64Build
set SolutionName=MYGUI.sln

::Less likely to need to change these.
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath="%~dp0%SrcFolder%"

::Variables need to be set here
set Variables=-D MYGUI_BUILD_DEMOS=0 ^
-D MYGUI_BUILD_PLUGINS=0 ^
-D MYGUI_BUILD_TOOLS=0 ^
-D MYGUI_DEPENDENCIES_DIR=%RootDependencyFolder%OgreDeps\Win64Install ^
-D MYGUI_STATIC=1 ^
-D OGRE_BUILD=%RootDependencyFolder%Ogre\Win64Build ^
-D OGRE_SOURCE=%RootDependencyFolder%Ogre\src ^
-D OGRE_SOURCE_DIR=%RootDependencyFolder%Ogre\src

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

cmake -G "%GeneratorName%" %Variables% %SrcPath%

msbuild.exe /m "%SolutionName%" /property:Configuration=Debug;Platform=%Platform%
msbuild.exe /m "%SolutionName%" /property:Configuration=Release;Platform=%Platform%

cd %CurrentDirectory%