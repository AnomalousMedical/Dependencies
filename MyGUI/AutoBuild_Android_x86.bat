::Configuration Settings
set GeneratorName=Visual Studio 14
set Platform=Tegra-Android
set SrcFolder=src
set BuildFolder=AndroidBuildx86
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
-D MYGUI_STATIC=1 ^
-D OGRE_BUILD=%RootDependencyFolder%Ogre\AndroidBuildx86\include ^
-D OGRE_CONFIG_INCLUDE_DIR=%RootDependencyFolder%Ogre\AndroidBuildx86\include ^
-D OGRE_INCLUDE_DIR=%RootDependencyFolder%Ogre\src\OgreMain\include;%RootDependencyFolder%Ogre\AndroidBuildx86\include ^
-D OGRE_LIBRARY_DBG=%RootDependencyFolder%Ogre\AndroidBuildx86\lib\libOgreMain.so ^
-D OGRE_LIBRARY_REL=%RootDependencyFolder%Ogre\AndroidBuildx86\lib\libOgreMain.so ^
-D OGRE_LIB_DIR=%RootDependencyFolder%Ogre\AndroidBuildx86\lib ^
-D OGRE_LIBRARIES=%RootDependencyFolder%Ogre\AndroidBuildx86\lib ^
-D OGRE_SOURCE=%RootDependencyFolder%Ogre\src ^
-D MYGUI_TRY_TO_COPY_DLLS=0 ^
-D ANDROID=1 ^
-D MYGUI_DEPENDENCIES_DIR=%RootDependencyFolder%OgreDeps/AndroidInstallx86 ^
-D FREETYPE_FT2BUILD_INCLUDE_DIR=%RootDependencyFolder%OgreDeps/AndroidInstallx86/include ^
-D FREETYPE_INCLUDE_DIR=%RootDependencyFolder%OgreDeps/AndroidInstallx86/include/freetype ^
-D FREETYPE_LIBRARY_REL=%RootDependencyFolder%OgreDeps/AndroidInstallx86/lib/libfreetype.a ^
-DCMAKE_TOOLCHAIN_FILE=%SrcPath%\cmake\toolchain\android.toolchain.cmake ^
-DLIBRARY_OUTPUT_PATH_ROOT=%BuildPath% ^
-DCMAKE_BUILD_TYPE=Release ^
-DANDROID_ABI=x86 ^
-DCMAKE_SYSTEM_NAME=Android

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

cmake -G "%GeneratorName%" -A %Platform% %Variables% %SrcPath%

msbuild.exe "%SolutionName%" /property:Configuration=Release;Platform=%Platform%;AndroidArch=x86

cd %CurrentDirectory%