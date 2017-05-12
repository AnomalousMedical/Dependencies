::Configuration Settings
set GeneratorName=Visual Studio 15 ARM
set SrcFolder=src
set BuildFolder=AndroidBuild
set SolutionName=BULLET_PHYSICS.sln
set Platform=ARM

::Less likely to need to change these.
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath="%~dp0%SrcFolder%"

::Use Modified CMake
set OldPath=%PATH%
::set PATH=%RootDependencyFolder%CMake-Modified\WindowsBuild\bin\Release;%PATH%

::Variables have to be defined here to get install path right, change if needed
set Variables=-D BUILD_CPU_DEMOS=0 ^
-D BUILD_BULLET3=0 ^
-D BUILD_BULLET2_DEMOS=0 ^
-D BUILD_MINICL_OPENCL_DEMOS=0 ^
-D BUILD_OPENGL3_DEMOS=0 ^
-D USE_GLUT=0 ^
-D USE_GRAPHICAL_BENCHMARK=0 ^
-DCMAKE_TOOLCHAIN_FILE=%SrcPath%\build3\android.toolchain.cmake ^
-DLIBRARY_OUTPUT_PATH_ROOT=%BuildPath% ^
-DCMAKE_BUILD_TYPE=Release ^
-DANDROID_NATIVE_API_LEVEL=19 ^
-DCMAKE_GENERATOR_TOOLSET=Gcc_4_9 ^
-DANDROID_ABI=armeabi-v7a

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