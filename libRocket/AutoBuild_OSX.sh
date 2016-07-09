#!/bin/sh

#Discover some stuff about where we are.
START_PATH=$(pwd)
THIS_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#Configuration
BASE_BUILD_FOLDER=$THIS_FOLDER/OSXBuild
GENERATOR_NAME=Xcode
SOURCE_FOLDER=$THIS_FOLDER/src/Build
BUILD_FOLDER_X86=$BASE_BUILD_FOLDER/x86
BUILD_FOLDER=$BUILD_FOLDER_X86
CMAKE_SETTINGS="-D CMAKE_OSX_DEPLOYMENT_TARGET=10.7 \
-D CMAKE_INSTALL_PREFIX=$BUILD_FOLDER/Install \
-D FREETYPE_INCLUDE_DIR_freetype2=$THIS_FOLDER/../OgreDeps/OSXInstall/include/freetype \
-D FREETYPE_INCLUDE_DIR_ft2build=$THIS_FOLDER/../OgreDeps/OSXInstall/include \
-D FREETYPE_LIBRARY=$THIS_FOLDER/../OgreDeps/OSXInstall/lib/libfreetype.a \
-D BUILD_FRAMEWORK=0 \
-D BUILD_LUA_BINDINGS=0 \
-D BUILD_PYTHON_BINDINGS=0 \
-D BUILD_SAMPLES=0 \
-D BUILD_SHARED_LIBS=0 \
-D BUILD_UNIVERSAL_BINARIES=0"

#Does not want to build unified, so do each arch and lipo them together

#Do x86 Build
#Make sure the build directories are empty by removing them
rm -r "$BASE_BUILD_FOLDER"

#Create the framework
mkdir -p "$BUILD_FOLDER"
cd "$BUILD_FOLDER"

cmake -G "$GENERATOR_NAME" $CMAKE_SETTINGS $SOURCE_FOLDER

#Build with XCode
xcodebuild -configuration Release SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH" ARCHS="i386"
#Under xcode 6 RocketControls does not build automatically, so build it explicitly
xcodebuild -configuration Release -target RocketControls SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH" ARCHS="i386"

#Do x64 Build
BUILD_FOLDER_X64=$BASE_BUILD_FOLDER/x64
BUILD_FOLDER=$BUILD_FOLDER_X64

#Create the framework
mkdir -p "$BUILD_FOLDER"
cd "$BUILD_FOLDER"

cmake -G "$GENERATOR_NAME" $CMAKE_SETTINGS $SOURCE_FOLDER

#Build with XCode
xcodebuild -configuration Release SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH" ARCHS="x86_64"
#Under xcode 6 RocketControls does not build automatically, so build it explicitly
xcodebuild -configuration Release -target RocketControls SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH" ARCHS="x86_64"

mkdir $BASE_BUILD_FOLDER/Release

lipo -create \
$BUILD_FOLDER_X86/Release/libRocketControls.a \
$BUILD_FOLDER_X64/Release/libRocketControls.a \
-output \
$BASE_BUILD_FOLDER/Release/libRocketControls.a

lipo -create \
$BUILD_FOLDER_X86/Release/libRocketCore.a \
$BUILD_FOLDER_X64/Release/libRocketCore.a \
-output \
$BASE_BUILD_FOLDER/Release/libRocketCore.a

lipo -create \
$BUILD_FOLDER_X86/Release/libRocketDebugger.a \
$BUILD_FOLDER_X64/Release/libRocketDebugger.a \
-output \
$BASE_BUILD_FOLDER/Release/libRocketDebugger.a

#Finish up
cd "$START_PATH"