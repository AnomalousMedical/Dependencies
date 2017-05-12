::Configuration Settings
set GeneratorName=Visual Studio 15
set Platform=Win32
set SrcFolder=src
set BuildFolder=WindowsBuild
set SolutionName=BULLET_PHYSICS.sln
set Variables=-D BUILD_CPU_DEMOS=0 ^
-D BUILD_BULLET3=0 ^
-D BUILD_BULLET2_DEMOS=0 ^
-D BUILD_MINICL_OPENCL_DEMOS=0 ^
-D BUILD_OPENGL3_DEMOS=0 ^
-D USE_GLUT=0 ^
-D USE_GRAPHICAL_BENCHMARK=0 ^
-D USE_MSVC_RUNTIME_LIBRARY_DLL=1 ^
-D USE_MSVC_FAST_FLOATINGPOINT=1

::Less likely to need to change these.
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath="%~dp0%SrcFolder%"

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

cmake -G "%GeneratorName%" %Variables% %SrcPath%

msbuild.exe "%SolutionName%" /property:Configuration=Debug;Platform=%Platform%
msbuild.exe "%SolutionName%" /property:Configuration=Release;Platform=%Platform%

cd %CurrentDirectory%