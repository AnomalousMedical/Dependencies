::Per Project Configuration Settings
set GeneratorName=Visual Studio 15 ARM
set SrcFolder=src
set BuildFolder=AndroidBuild
set SolutionName=OGRE.sln

::Auto Configuration
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set BuildPath="%ThisFolder%%BuildFolder%"
set SrcPath="%ThisFolder%%SrcFolder%"
::End Auto Configuration

::Use Modified CMake
set OldPath=%PATH%
::set PATH=%RootDependencyFolder%CMake-Modified\WindowsBuild\bin\Release;%PATH%

::Variables have to be defined here to get install path right, change if needed
set Variables=-DCMAKE_TOOLCHAIN_FILE=%SrcPath%\CMake\toolchain\android.toolchain.cmake ^
-DCMAKE_BUILD_TYPE=Release ^
-DCMAKE_SYSTEM_NAME=Android ^
-D OGRE_CONFIG_ENABLE_GLES3_SUPPORT=0 ^
-D OGRE_BUILD_COMPONENT_MESHLODGENERATOR=0 ^
-D OGRE_BUILD_COMPONENT_OVERLAY=0 ^
-D OGRE_BUILD_COMPONENT_PAGING=0 ^
-D OGRE_BUILD_COMPONENT_RTSHADERSYSTEM=0 ^
-D OGRE_BUILD_COMPONENT_TERRAIN=0 ^
-D OGRE_BUILD_COMPONENT_VOLUME=0 ^
-D OGRE_BUILD_PLUGIN_BSP=0 ^
-D OGRE_BUILD_PLUGIN_CG=0 ^
-D OGRE_BUILD_PLUGIN_OCTREE=0 ^
-D OGRE_BUILD_PLUGIN_PCZ=0 ^
-D OGRE_BUILD_PLUGIN_PFX=0 ^
-D OGRE_BUILD_SAMPLES=0 ^
-D OGRE_BUILD_TOOLS=0 ^
-D OGRE_COPY_DEPENDENCIES=0 ^
-D OGRE_INSTALL_DEPENDENCIES=0 ^
-D OGRE_INSTALL_DOCS=0 ^
-D OGRE_INSTALL_PDB=0 ^
-D OGRE_INSTALL_SAMPLES=0 ^
-D OGRE_INSTALL_TOOLS=0 ^
-DLIBRARY_OUTPUT_PATH_ROOT=%BuildPath% ^
-D OGRE_DEPENDENCIES_DIR=%RootDependencyFolder%\OgreDeps\AndroidInstall ^
-DANDROID_NATIVE_API_LEVEL=19 ^
-DCMAKE_GENERATOR_TOOLSET=Gcc_4_9 ^
-DANDROID_ABI=armeabi-v7a

::Acutal build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

%RootDependencyFolder%CMake-Modified\WindowsBuild\bin\Release\cmake -G "%GeneratorName%" %Variables% %SrcPath%

:: Small hack to fix the output file names since cmake cannot do this on its own for now
%RootDependencyFolder%CMakeHacks.exe replace %BuildPath% *.vcxproj "<ObjectFileName>$(IntDir)</ObjectFileName>" "<ObjectFileName>$(IntDir)%%(filename).o</ObjectFileName>"

msbuild.exe /m "%SolutionName%" /property:Configuration=Release;Platform="ARM"

cd %CurrentDirectory%

::Set Path back
set PATH=%OldPath%