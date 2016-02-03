::Configuration Settings
set GeneratorName=Visual Studio 14
set SrcFolder=src
set BuildFolder=AndroidBuildx86
set SolutionName=BULLET_PHYSICS.sln
set Platform=Tegra-Android

::Less likely to need to change these.
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath="%~dp0%SrcFolder%"

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
-DANDROID_ABI=x86

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

cmake -G "%GeneratorName%" %Variables% %SrcPath%

msbuild.exe "%SolutionName%" /property:Configuration=Release;Platform=%Platform%;AndroidArch=x86

cd %CurrentDirectory%