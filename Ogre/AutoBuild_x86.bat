::Location Info
set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\

::Configuration Settings
set GeneratorName=Visual Studio 14
set Platform=Win32
set SrcFolder=src
set BuildFolder=WindowsBuild
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
-D EGL_INCLUDE_DIR=%RootDependencyFolder%\angle-ms\include\EGL ^
-D EGL_egl_LIBRARY=%RootDependencyFolder%\angle-ms\src\Release_Win32\lib\libEGL.lib ^
-D OPENGLES2_INCLUDE_DIR=%RootDependencyFolder%\angle-ms\include ^
-D OPENGLES2_gl_LIBRARY=%RootDependencyFolder%\angle-ms\src\Release_Win32\lib\libGLESv2.lib ^
-D OPENGLES3_INCLUDE_DIR=%RootDependencyFolder%\angle-ms\include ^
-D OPENGLES3_gl_LIBRARY=%RootDependencyFolder%\angle-ms\src\Release_Win32\lib\libGLESv2.lib ^
-D OGRE_BUILD_RENDERSYSTEM_GLES2=1 ^
-D OGRE_CONFIG_ENABLE_GLES3_SUPPORT=0 ^
-D OGRE_DEPENDENCIES_DIR=%RootDependencyFolder%\OgreDeps\WindowsInstall

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