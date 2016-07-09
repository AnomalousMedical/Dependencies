#!/bin/sh

#Discover some stuff about where we are.
START_PATH=$(pwd)
THIS_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#Configuration
GENERATOR_NAME=Xcode
SOURCE_FOLDER=$THIS_FOLDER/src
BUILD_FOLDER=$THIS_FOLDER/OSXBuild
CMAKE_SETTINGS="-D BUILD_CPU_DEMOS=0 \
-D BUILD_BULLET3=0 \
-D BUILD_BULLET2_DEMOS=0 \
-D BUILD_MINICL_OPENCL_DEMOS=0 \
-D BUILD_OPENGL3_DEMOS=0 \
-D USE_GLUT=0 \
-D USE_GRAPHICAL_BENCHMARK=0 \
-D BUILD_UNIT_TESTS=0 \
-D CMAKE_INSTALL_PREFIX=$BUILD_FOLDER/Install \
-D CMAKE_OSX_ARCHITECTURES=i386 \
-D CMAKE_OSX_DEPLOYMENT_TARGET=10.7"

#Do Build
#Make sure the build directories are empty by removing them
rm -r "$BUILD_FOLDER"

#Create the framework
mkdir "$BUILD_FOLDER"
cd "$BUILD_FOLDER"

cmake -G "$GENERATOR_NAME" $CMAKE_SETTINGS $SOURCE_FOLDER

#Build with XCode
xcodebuild -configuration Release SHARED_PRECOMPS_DIR="$BUILD_FOLDER/SharedTmpPCH" ARCHS="i386 x86_64"

#Finish up
cd "$START_PATH"