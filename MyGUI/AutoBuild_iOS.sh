#!/bin/sh

#Discover some stuff about where we are.
START_PATH=$(pwd)
THIS_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#Configuration
GENERATOR_NAME=Xcode
SOURCE_FOLDER=$THIS_FOLDER/Src
BUILD_FOLDER=$THIS_FOLDER/iOSBuild
ROOT_DEP_FOLDER=$THIS_FOLDER/..
CMAKE_SETTINGS="-D CMAKE_INSTALL_PREFIX=$BUILD_FOLDER/Install \
-D MYGUI_BUILD_DEMOS=0 \
-D MYGUI_BUILD_PLUGINS=0 \
-D MYGUI_BUILD_TOOLS=0 \
-D MYGUI_STATIC=1 \
-D OGRE_BUILD=$ROOT_DEP_FOLDER/Ogre/iOSBuild \
-D OGRE_SOURCE=$ROOT_DEP_FOLDER/Ogre/src \
-D OGRE_SOURCE_DIR=$ROOT_DEP_FOLDER/Ogre\src \
-D OGRE_BUILD_PLATFORM_APPLE_IOS=1 \
-D OGRE_STATIC=1 \
-D MYGUI_DEPENDENCIES_DIR=$ROOT_DEP_FOLDER/OgreDeps/iOSInstall \
-D FREETYPE_LIBRARY_REL=$ROOT_DEP_FOLDER/OgreDeps/iOSInstall/lib/Release/libfreetype.a"

#Do Build
#Make sure the build directories are empty by removing them
rm -r "$BUILD_FOLDER"

#Create the framework
mkdir "$BUILD_FOLDER"
cd "$BUILD_FOLDER"

cmake -G "$GENERATOR_NAME" $CMAKE_SETTINGS $SOURCE_FOLDER

#Build with XCode
xcodebuild -configuration Release -sdk iphoneos ONLY_ACTIVE_ARCH=NO ARCHS="arm64" SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH"

#Finish up
cd "$START_PATH"