#!/bin/sh

# MakeFramework.sh
# 
#
# Created by Andrew Piper on 1/18/11.
# Copyright 2011 Anomalous Software. All rights reserved.


FRAMEWORK_NAME="Mono.framework"
MONO_PATH="/Library/Frameworks/Mono.framework/Versions/Current"

#Discover some stuff about where we are.
START_PATH=$(pwd)
THIS_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

OUTPUT_PATH=$THIS_FOLDER/bin

rm -r "$OUTPUT_PATH"
mkdir "$OUTPUT_PATH"
cd "$OUTPUT_PATH"

#Create the framework
mkdir "$FRAMEWORK_NAME"
mkdir "$FRAMEWORK_NAME/lib"
mkdir "$FRAMEWORK_NAME/bin"
mkdir "$FRAMEWORK_NAME/cfg"

#Copy files
cp "$MONO_PATH/bin/mono" "$FRAMEWORK_NAME/bin"

#Copy mono .net files as needed
cp "$MONO_PATH/lib/mono/4.5/mscorlib.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/System.Xml.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/System.Xml.Linq.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/System.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/System.Core.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/System.Configuration.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/System.Runtime.Serialization.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/System.Security.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/System.Net.Http.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/Mono.Security.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/I18N.CJK.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/I18N.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/I18N.MidEast.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/I18N.Other.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/I18N.Rare.dll" "$FRAMEWORK_NAME/lib"
cp "$MONO_PATH/lib/mono/4.5/I18N.West.dll" "$FRAMEWORK_NAME/lib"

cd "$THIS_FOLDER/monomac"
make clean
make
cd src
cp core.dll "$OUTPUT_PATH/core.dll"
cp core.dll.mdb "$OUTPUT_PATH/core.dll.mdb"
cp MonoMac.dll "$OUTPUT_PATH/MonoMac.dll"
cp MonoMac.dll.mdb "$OUTPUT_PATH/MonoMac.dll.mdb"
cp MonoMac.CFNetwork.dll "$OUTPUT_PATH/MonoMac.CFNetwork.dll"
cp MonoMac.CFNetwork.dll.mdb "$OUTPUT_PATH/MonoMac.CFNetwork.dll.mdb"

#Finish up
cd "$START_PATH"