::Location Info
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\

::Configuration Settings
set GeneratorName=Visual Studio 14 Win64
set Platform=x64
set SrcFolder=src
set BuildFolder=Win64Build
set SolutionName=OGRE.sln
set Variables=-D OGRE_BUILD_COMPONENT_MESHLODGENERATOR=0 ^
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
-D OGRE_BUILD_RENDERSYSTEM_D3D9=0 ^
-D OGRE_BUILD_SAMPLES=0 ^
-D OGRE_BUILD_TOOLS=0 ^
-D OGRE_COPY_DEPENDENCIES=0 ^
-D OGRE_INSTALL_DEPENDENCIES=0 ^
-D OGRE_INSTALL_DOCS=0 ^
-D OGRE_INSTALL_PDB=0 ^
-D OGRE_INSTALL_SAMPLES=0 ^
-D OGRE_INSTALL_TOOLS=0 ^
-D OGRE_BUILD_COMPONENT_HLMS=0 ^
-D OGRE_BUILD_COMPONENT_PROPERTY=0 ^
-D OGRE_DEPENDENCIES_DIR=%RootDependencyFolder%\OgreDeps\Win64Install

::Less likely to need to change these.
set CurrentDirectory=%CD%

set BuildPath="%~dp0%BuildFolder%"
set SrcPath="%~dp0%SrcFolder%"

::Actual build process
rmdir /s /q %BuildPath%
mkdir %BuildPath%
cd %BuildPath%

cmake -G "%GeneratorName%" %Variables% %SrcPath%

:: Small hack to remove FREEIMAGE_LIB from the preprocessor, dont want to hack up ogre cmake to support our method of building freeimge dynamically
%RootDependencyFolder%CMakeHacks.exe replace %BuildPath% *.vcxproj ";FREEIMAGE_LIB;" ";"

msbuild.exe /m "%SolutionName%" /property:Configuration=Debug;Platform=%Platform%
msbuild.exe /m "%SolutionName%" /property:Configuration=Release;Platform=%Platform%

cd %CurrentDirectory%