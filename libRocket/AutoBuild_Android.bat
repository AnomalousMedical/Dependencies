::Configuration Settings
set GeneratorName=NMake Makefiles
set SrcFolder=src\Build
set BuildFolder=AndroidBuild
set GeneratorName=Visual Studio 14 ARM
set Platform=ARM
set SolutionName=libRocket.sln

::Less likely to need to change these.
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath=%~dp0%SrcFolder%

::Use Modified CMake
set OldPath=%PATH%
::set PATH=%RootDependencyFolder%CMake-Modified\WindowsBuild\bin\Release;%PATH%

::Variables need to be set here
set Variables=-D BUILD_SHARED_LIBS=0 ^
-D FREETYPE_INCLUDE_DIR_ft2build=%RootDependencyFolder%OgreDeps\AndroidInstall\include ^
-D FREETYPE_INCLUDE_DIR_freetype2=%RootDependencyFolder%OgreDeps\AndroidInstall\include\freetype ^
-D FREETYPE_LIBRARY=%RootDependencyFolder%OgreDeps\AndroidInstall\lib\libfreetype.a ^
-DCMAKE_TOOLCHAIN_FILE="%SrcPath%\cmake\Platform\android.toolchain.cmake" ^
-DLIBRARY_OUTPUT_PATH_ROOT=%BuildPath% ^
-DCMAKE_BUILD_TYPE=Release ^
-DANDROID_ABI=armeabi-v7a ^
-DCMAKE_GENERATOR_TOOLSET=Gcc_4_9 ^
-DCMAKE_SYSTEM_NAME=Android

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

%RootDependencyFolder%CMake-Modified\WindowsBuild\bin\Release\cmake -G "%GeneratorName%" %Variables% "%SrcPath%"

:: Small hack to fix the output file names since cmake cannot do this on its own for now
%RootDependencyFolder%CMakeHacks.exe replace %BuildPath% *.vcxproj "<ObjectFileName>$(IntDir)</ObjectFileName>" "<ObjectFileName>$(IntDir)%%(filename).o</ObjectFileName>"

msbuild.exe /m "%SolutionName%" /property:Configuration=Release;Platform=%Platform%

cd %CurrentDirectory%

::Set Path back
set PATH=%OldPath%