::Per Project Configuration Settings
set GeneratorName=Visual Studio 14 ARM
set SrcFolder=src
set BuildFolder=AndroidBuild
set InstallFolder=AndroidInstall
set SolutionName=INSTALL.vcxproj

::Auto Configuration
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%ThisFolder%%BuildFolder%"
set SrcPath="%ThisFolder%%SrcFolder%"
set InstallPath=%ThisFolder%%InstallFolder%
::End Auto Configuration

::Use Modified CMake
set OldPath=%PATH%
set PATH=%RootDependencyFolder%CMake-Modified\WindowsBuild\bin\Release;%PATH%

::Variables have to be defined here to get install path right, change if needed
set Variables=-D CMAKE_INSTALL_PREFIX=%InstallPath% ^
-DCMAKE_TOOLCHAIN_FILE=%SrcPath%\cmake\android.toolchain.cmake ^
-DLIBRARY_OUTPUT_PATH_ROOT=%BuildPath% ^
-DCMAKE_BUILD_TYPE=Release ^
-DANDROID_NATIVE_API_LEVEL=19 ^
-DCMAKE_GENERATOR_TOOLSET=Gcc_4_9 ^
-DANDROID_ABI=armeabi-v7a with NEON ^
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

cmake -G "%GeneratorName%" %Variables% %SrcPath%

:: Small hack to fix the output file names since cmake cannot do this on its own for now
%RootDependencyFolder%CMakeHacks.exe replace %BuildPath% *.vcxproj "<ObjectFileName>$(IntDir)</ObjectFileName>" "<ObjectFileName>$(IntDir)%%(filename).o</ObjectFileName>"
%RootDependencyFolder%CMakeHacks.exe replace %BuildPath% *.vcxproj "-mfpu=vfpv3-d16" "-mfpu=neon"

msbuild.exe /m "%SolutionName%" /property:Configuration=Release

cd %CurrentDirectory%

::Set Path back
set PATH=%OldPath%