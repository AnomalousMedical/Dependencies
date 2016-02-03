::Per Project Configuration Settings
set GeneratorName=Visual Studio 14
set SrcFolder=src
set BuildFolder=AndroidBuildx86
set InstallFolder=AndroidInstallx86
set SolutionName=INSTALL.vcxproj
set Platform=Tegra-Android

::Auto Configuration
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%ThisFolder%%BuildFolder%"
set SrcPath="%ThisFolder%%SrcFolder%"
set InstallPath=%ThisFolder%%InstallFolder%
::End Auto Configuration

::Variables have to be defined here to get install path right, change if needed
set Variables=-D CMAKE_INSTALL_PREFIX=%InstallPath% ^
-DCMAKE_TOOLCHAIN_FILE=%SrcPath%\cmake\android.toolchain.cmake ^
-DLIBRARY_OUTPUT_PATH_ROOT=%BuildPath% ^
-DCMAKE_BUILD_TYPE=Release ^
-DANDROID_NATIVE_API_LEVEL=9 ^
-DANDROID_ABI=x86

::Acutal build process
rmdir /s /q %InstallPath%
rmdir /s /q %BuildPath%
mkdir %BuildPath%
mkdir %InstallPath%
cd %BuildPath%

cmake -G "%GeneratorName%" %Variables% %SrcPath%

msbuild.exe "%SolutionName%" /property:Configuration=Release;Platform=%Platform%;AndroidArch=x86

cd %CurrentDirectory%