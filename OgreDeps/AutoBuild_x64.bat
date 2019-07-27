::Per Project Configuration Settings
set GeneratorName=Visual Studio 16
set Platform=x64
set SrcFolder=src
set BuildFolder=Win64Build
set InstallFolder=Win64Install
set SolutionName=INSTALL.vcxproj

::Auto Configuration
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%ThisFolder%%BuildFolder%"
set SrcPath="%ThisFolder%%SrcFolder%"
set InstallPath=%ThisFolder%%InstallFolder%
::End Auto Configuration

::Variables have to be defined here to get install path right, change if needed
set Variables=-DCMAKE_INSTALL_PREFIX=%InstallPath% ^
-DBUILD_PLUGIN_CUT=0 ^
-DBUILD_PLUGIN_EXR=0 ^
-DBUILD_PLUGIN_HDR=0 ^
-DBUILD_PLUGIN_ICO=0 ^
-DBUILD_PLUGIN_IFF=0 ^
-DBUILD_PLUGIN_KOALA=0 ^
-DBUILD_PLUGIN_PICT=0 ^
-DBUILD_PLUGIN_RAW=0 ^
-DBUILD_PLUGIN_TIFF=0 ^
-DBUILD_PLUGIN_JXR=0 ^
-DBUILD_PLUGIN_G3=0 ^
-DOGREDEPS_BUILD_FREEIMAGE_DYNAMIC=1

::Acutal build process
rmdir /s /q %InstallPath%
rmdir /s /q %BuildPath%
mkdir %BuildPath%
mkdir %InstallPath%
cd %BuildPath%

cmake -G "%GeneratorName%" -A %Platform% %Variables% %SrcPath%

msbuild.exe /m "%SolutionName%" /property:Configuration=Debug;Platform=%Platform%
msbuild.exe /m "%SolutionName%" /property:Configuration=Release;Platform=%Platform%

cd %CurrentDirectory%