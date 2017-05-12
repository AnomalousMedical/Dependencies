::Configuration Settings
set GeneratorName=Visual Studio 14 ARM
set Platform=ARM
set SrcFolder=src
set BuildFolder=AndroidBuild
set SolutionName=MYGUI.sln

::Less likely to need to change these.
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath="%~dp0%SrcFolder%"

::Use Modified CMake
set OldPath=%PATH%
::set PATH=%RootDependencyFolder%CMake-Modified\WindowsBuild\bin\Release;%PATH%

::Variables need to be set here
set Variables=-D MYGUI_BUILD_DEMOS=0 ^
-D MYGUI_BUILD_PLUGINS=0 ^
-D MYGUI_BUILD_TOOLS=0 ^
-D MYGUI_STATIC=1 ^
-D OGRE_BUILD=%RootDependencyFolder%Ogre\AndroidBuild\include ^
-D OGRE_CONFIG_INCLUDE_DIR=%RootDependencyFolder%Ogre\AndroidBuild\include ^
-D OGRE_INCLUDE_DIR=%RootDependencyFolder%Ogre\src\OgreMain\include;%RootDependencyFolder%Ogre\AndroidBuild\include ^
-D OGRE_LIBRARY_DBG=%RootDependencyFolder%Ogre\AndroidBuild\lib\libOgreMain.so ^
-D OGRE_LIBRARY_REL=%RootDependencyFolder%Ogre\AndroidBuild\lib\libOgreMain.so ^
-D OGRE_LIB_DIR=%RootDependencyFolder%Ogre\AndroidBuild\lib ^
-D OGRE_LIBRARIES=%RootDependencyFolder%Ogre\AndroidBuild\lib ^
-D OGRE_SOURCE=%RootDependencyFolder%Ogre\src ^
-D MYGUI_TRY_TO_COPY_DLLS=0 ^
-D ANDROID=1 ^
-D MYGUI_DEPENDENCIES_DIR=%RootDependencyFolder%OgreDeps/AndroidInstall ^
-D FREETYPE_FT2BUILD_INCLUDE_DIR=%RootDependencyFolder%OgreDeps/AndroidInstall/include ^
-D FREETYPE_INCLUDE_DIR=%RootDependencyFolder%OgreDeps/AndroidInstall/include/freetype ^
-D FREETYPE_LIBRARY_REL=%RootDependencyFolder%OgreDeps/AndroidInstall/lib/libfreetype.a ^
-DCMAKE_TOOLCHAIN_FILE=%SrcPath%\cmake\toolchain\android.toolchain.cmake ^
-DLIBRARY_OUTPUT_PATH_ROOT=%BuildPath% ^
-DCMAKE_BUILD_TYPE=Release ^
-DANDROID_ABI=armeabi-v7a ^
-DCMAKE_GENERATOR_TOOLSET=Gcc_4_9 ^
-DCMAKE_SYSTEM_NAME=Android

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

%RootDependencyFolder%CMake-Modified\WindowsBuild\bin\Release\cmake -G "%GeneratorName%" %Variables% %SrcPath%

:: Small hack to fix the output file names since cmake cannot do this on its own for now
%RootDependencyFolder%CMakeHacks.exe replace %BuildPath% *.vcxproj "<ObjectFileName>$(IntDir)</ObjectFileName>" "<ObjectFileName>$(IntDir)%%(filename).o</ObjectFileName>"

msbuild.exe /m "%SolutionName%" /property:Configuration=Release;Platform=%Platform%

cd %CurrentDirectory%

::Set Path back
set PATH=%OldPath%