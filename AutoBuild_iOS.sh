#!/bin/sh

#Discover some stuff about where we are.
START_PATH=$(pwd)
THIS_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

sh $THIS_FOLDER/OgreDeps/AutoBuild_iOS.sh
sh $THIS_FOLDER/Ogre/AutoBuild_iOS.sh
sh $THIS_FOLDER/Bullet/AutoBuild_iOS.sh
sh $THIS_FOLDER/DotNetZip/AutoBuild_Xbuild.sh
sh $THIS_FOLDER/FreeImage.NET/AutoBuild_Xbuild_Static.sh
#Just links manually to the static freeimage native built by ogre
sh $THIS_FOLDER/Irony/AutoBuild_Xbuild.sh
sh $THIS_FOLDER/libRocket/AutoBuild_iOS.sh
sh $THIS_FOLDER/Lucene.net/AutoBuild_Xbuild.sh
sh $THIS_FOLDER/Mono/AutoBuild_Xbuild.sh
sh $THIS_FOLDER/MSBuild/AutoBuild_Xbuild.sh
sh $THIS_FOLDER/MyGUI/AutoBuild_iOS.sh
sh $THIS_FOLDER/oggvorbis/AutoBuild_iOS.sh

#Finish up
cd "$START_PATH"