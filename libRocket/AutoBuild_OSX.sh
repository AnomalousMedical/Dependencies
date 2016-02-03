#!/bin/sh

#Discover some stuff about where we are.
START_PATH=$(pwd)
THIS_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#Configuration
GENERATOR_NAME=Xcode
SOURCE_FOLDER=$THIS_FOLDER/src/Build
BUILD_FOLDER=$THIS_FOLDER/OSXBuild
CMAKE_SETTINGS="-D CMAKE_OSX_ARCHITECTURES=i386 \
-D CMAKE_OSX_DEPLOYMENT_TARGET=10.7 \
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

#Do Build
#Make sure the build directories are empty by removing them
rm -r "$BUILD_FOLDER"

#Create the framework
mkdir "$BUILD_FOLDER"
cd "$BUILD_FOLDER"

cmake -G "$GENERATOR_NAME" $CMAKE_SETTINGS $SOURCE_FOLDER

#Build with XCode
xcodebuild -configuration Release SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH"
#Under xcode 6 RocketControls does not build automatically, so build it explicitly
xcodebuild -configuration Release -target RocketControls SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH"

#Finish up
cd "$START_PATH"