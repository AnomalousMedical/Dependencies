#!/bin/sh

#Discover some stuff about where we are.
START_PATH=$(pwd)
THIS_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#Configuration
GENERATOR_NAME=Xcode
SOURCE_FOLDER=$THIS_FOLDER/src
BUILD_FOLDER=$THIS_FOLDER/iOSBuild
OUTPUT_FOLDER=$THIS_FOLDER/iOSInstall
CMAKE_SETTINGS="-D CMAKE_INSTALL_PREFIX=$OUTPUT_FOLDER \
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
-D OGRE_BUILD_PLATFORM_APPLE_IOS=1"

#Do Build
#Make sure the build directories are empty by removing them
rm -r "$BUILD_FOLDER"
rm -r "$OUTPUT_FOLDER"

#Create the framework
mkdir "$BUILD_FOLDER"
cd "$BUILD_FOLDER"

cmake -G "$GENERATOR_NAME" $CMAKE_SETTINGS $SOURCE_FOLDER

#Build with Xcode, note this builds both the simulator and ios versions and joins them with lipo as part of the cmake build process
#If Xcode is updated the -sdk listed here might not be valid, you can run xcodebuild -showsdks to list them and fix this.
xcodebuild -configuration Release -target install -sdk iphonesimulator SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH_i386"
xcodebuild -configuration Release -target install SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH_arm"

#We lipo OIS manually since on a case sensitive os the cmake script does not build correctly, but would take large mods to fix
lipo -create $BUILD_FOLDER/src/ois/Release-iphoneos/libOIS.a $BUILD_FOLDER/src/ois/Release-iphonesimulator/libOIS.a -output $OUTPUT_FOLDER/lib/Release/libOIS.a

#Finish up
cd "$START_PATH"