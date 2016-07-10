#!/bin/sh

#Discover some stuff about where we are.
START_PATH=$(pwd)
THIS_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

sh $THIS_FOLDER/OgreDeps/AutoBuild_OSX.sh
sh $THIS_FOLDER/Ogre/AutoBuild_OSX.sh
sh $THIS_FOLDER/Bullet/AutoBuild_OSX.sh
sh $THIS_FOLDER/libRocket/AutoBuild_OSX.sh
sh $THIS_FOLDER/MSBuild/AutoBuild_Xbuild.sh
sh $THIS_FOLDER/MyGUI/AutoBuild_OSX.sh
sh $THIS_FOLDER/oggvorbis/AutoBuild_OSX.sh

#Finish up
cd "$START_PATH"