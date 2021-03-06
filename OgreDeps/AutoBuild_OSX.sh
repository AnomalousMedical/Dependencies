#!/bin/sh

#Discover some stuff about where we are.
START_PATH=$(pwd)
THIS_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#Configuration
GENERATOR_NAME=Xcode
SOURCE_FOLDER=$THIS_FOLDER/src
BUILD_FOLDER=$THIS_FOLDER/OSXBuild
OUTPUT_FOLDER=$THIS_FOLDER/OSXInstall
CMAKE_SETTINGS="-D CMAKE_INSTALL_PREFIX=$OUTPUT_FOLDER \
-D CMAKE_OSX_DEPLOYMENT_TARGET=10.7 \
-DBUILD_PLUGIN_CUT=0 \
-DBUILD_PLUGIN_EXR=0 \
-DBUILD_PLUGIN_HDR=0 \
-DBUILD_PLUGIN_ICO=0 \
-DBUILD_PLUGIN_IFF=0 \
-DBUILD_PLUGIN_KOALA=0 \
-DBUILD_PLUGIN_PICT=0 \
-DBUILD_PLUGIN_RAW=0 \
-DBUILD_PLUGIN_TIFF=0 \
-DBUILD_PLUGIN_JXR=0 \
-DBUILD_PLUGIN_G3=0 \
-DOGREDEPS_BUILD_FREEIMAGE_DYNAMIC=1"

#Do Build
#Make sure the build directories are empty by removing them
rm -r "$BUILD_FOLDER"
rm -r "$OUTPUT_FOLDER"

#Create the framework
mkdir "$BUILD_FOLDER"
cd "$BUILD_FOLDER"

cmake -G "$GENERATOR_NAME" $CMAKE_SETTINGS $SOURCE_FOLDER

#Build with XCode
xcodebuild -configuration Release -target install SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH" ARCHS="i386 x86_64"

#The freeimage dylib does not copy with the correct install name, so copy it again with what we actually want
xcodebuild -configuration Release -target FreeImage SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH" ARCHS="i386 x86_64" DYLIB_INSTALL_NAME_BASE="@executable_path/../MonoBundle" LD_DYLIB_INSTALL_NAME="@executable_path/../MonoBundle/libFreeImage.dylib"

cp "$BUILD_FOLDER/src/FreeImage/Release/libFreeImage.dylib" "$OUTPUT_FOLDER/lib/libFreeImage.dylib"

#Finish up
cd "$START_PATH"