::Configuration Settings
set SrcFolder=src\Build
set BuildFolder=AndroidBuildx86
set GeneratorName=Visual Studio 14
set Platform=Tegra-Android
set SolutionName=libRocket.sln

::Less likely to need to change these.
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath=%~dp0%SrcFolder%

::Variables need to be set here
set Variables=-D BUILD_SHARED_LIBS=0 ^
-D FREETYPE_INCLUDE_DIR_ft2build=%RootDependencyFolder%OgreDeps\AndroidInstallx86\include ^
-D FREETYPE_INCLUDE_DIR_freetype2=%RootDependencyFolder%OgreDeps\AndroidInstallx86\include\freetype ^
-D FREETYPE_LIBRARY=%RootDependencyFolder%OgreDeps\AndroidInstallx86\lib\libfreetype.a ^
-DCMAKE_TOOLCHAIN_FILE="%SrcPath%\cmake\Platform\android.toolchain.cmake" ^
-DLIBRARY_OUTPUT_PATH_ROOT=%BuildPath% ^
-DCMAKE_BUILD_TYPE=Release ^
-DANDROID_ABI=x86 ^
-DCMAKE_SYSTEM_NAME=Android

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

cmake -G "%GeneratorName%" %Variables% "%SrcPath%"

msbuild.exe "%SolutionName%" /property:Configuration=Release;Platform=%Platform%;AndroidArch=x86

cd %CurrentDirectory%