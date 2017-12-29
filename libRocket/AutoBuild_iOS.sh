#!/bin/sh

#Discover some stuff about where we are.
START_PATH=$(pwd)
THIS_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#Configuration
#Even though libRocket has iOS build stuff in its cmake we are instead telling cmake to build for osx
#and then overriding xcodebuild to build for ios instead.
GENERATOR_NAME=Xcode
SOURCE_FOLDER=$THIS_FOLDER/src/Build
BUILD_FOLDER=$THIS_FOLDER/iOSBuild
CMAKE_SETTINGS="-D CMAKE_INSTALL_PREFIX=$BUILD_FOLDER/Install \
-D FREETYPE_INCLUDE_DIR_freetype2=$THIS_FOLDER/../OgreDeps/iOSInstall/include/freetype \
-D FREETYPE_INCLUDE_DIR_ft2build=$THIS_FOLDER/../OgreDeps/iOSInstall/include \
-D FREETYPE_LIBRARY=$THIS_FOLDER/../OgreDeps/iOSInstall/lib/libfreetype.a \
-D BUILD_FRAMEWORK=0 \
-D BUILD_LUA_BINDINGS=0 \
-D BUILD_PYTHON_BINDINGS=0 \
-D BUILD_SAMPLES=0 \
-D BUILD_SHARED_LIBS=0"

#Do Build
#Make sure the build directories are empty by removing them
rm -r "$BUILD_FOLDER"

#Create the framework
mkdir "$BUILD_FOLDER"
cd "$BUILD_FOLDER"

cmake -G "$GENERATOR_NAME" $CMAKE_SETTINGS $SOURCE_FOLDER

#Build with XCode, still building RocketControls separately
xcodebuild -configuration Release -sdk iphoneos ONLY_ACTIVE_ARCH=NO ARCHS="arm64" SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH_device"
xcodebuild -configuration Release -sdk iphoneos ONLY_ACTIVE_ARCH=NO ARCHS="arm64" -target RocketControls SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH_device"

#Finish up
cd "$START_PATH"