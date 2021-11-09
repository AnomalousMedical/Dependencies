::Location Info
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\

::Configuration Settings
set GeneratorName=Visual Studio 17
set Platform=x64
set SrcFolder=DiligentCore
set BuildFolder=Win64Build
set SolutionName=DiligentCore.sln
set Variables=-D PYTHON_EXECUTABLE="%ThisFolder%/../../Python/python.exe" ^
 -D DILIGENT_NO_OPENGL=1 ^
 -D DILIGENT_NO_DIRECT3D11=1 ^
 -D DILIGENT_NO_DIRECT3D12=1

::Less likely to need to change these.
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath="%~dp0%SrcFolder%"

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

cmake -G "%GeneratorName%" -A %Platform% %Variables% %SrcPath%

:: Small hack to remove FREEIMAGE_LIB from the preprocessor, dont want to hack up ogre cmake to support our method of building freeimge dynamically
%RootDependencyFolder%CMakeHacks.exe replace %BuildPath% *.vcxproj ";FREEIMAGE_LIB;" ";"

msbuild.exe /m "%SolutionName%" /property:Configuration=Debug;Platform=%Platform%
msbuild.exe /m "%SolutionName%" /property:Configuration=Release;Platform=%Platform%

cd %CurrentDirectory%