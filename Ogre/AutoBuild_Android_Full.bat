::Per Project Configuration Settings
set GeneratorName=NMake Makefiles
set SrcFolder=src
set BuildFolder=AndroidBuildFull

::Auto Configuration
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%ThisFolder%%BuildFolder%"
set SrcPath="%ThisFolder%%SrcFolder%"
::End Auto Configuration

::Variables have to be defined here to get install path right, change if needed
set Variables=-DCMAKE_TOOLCHAIN_FILE=%SrcPath%\CMake\toolchain\android.toolchain.cmake ^
-DCMAKE_BUILD_TYPE=Release ^
-DLIBRARY_OUTPUT_PATH_ROOT=%BuildPath% ^
-D OGRE_DEPENDENCIES_DIR=%RootDependencyFolder%\OgreDeps\AndroidInstall ^
-DANDROID_NATIVE_API_LEVEL=9 ^
-DOGRE_STATIC=1 ^
-DANDROID_ABI=armeabi-v7a

::Acutal build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

cmake -G "%GeneratorName%" -A %Platform% %Variables% %SrcPath%
nmake

cd %CurrentDirectory%