# Anomalous Medical Dependencies
These are the dependencies that are needed to build Anomalous Medical.

The currently supported environment is vs2019, Windows 10 SDK 10.0.18362.0 and cmake 3.15.1. Other versions may work, but this is the tested configuration.

## Building
The easiest way to build is to open the Developer Command Prompt for vs 2017 and then run one of the following:
 * AutoBuild_Win32.bat - Build the Windows version, both x86 and x64. You really need both for the downstream projects to work.
 * Autobuild_Android - Build the Android version. If you are going to build this by itself build AndroidPrereq.bat first to make the custom cmake, which is needed by the Android build.
 You can run AutoBuild_AndroidWithPrereqs.bat to build the custom cmake and android at the same time.

## Android
This version can build android, but you must install the [13b ndk](https://developer.android.com/ndk/downloads/older_releases) and set ANDROID_NDK to the path. This will make the cmake scripts work. For best results set Visual Studio to use this ndk version. The one it installs (16b) seems to work if 13b makes the cmake files, but the zip library in engine won't compile.

## Unsupported Configurations
There are a few more build configurations in this folder.

The x86 Android builds never really worked and are pretty rare device wise anyway.

The iOS and Mac OS versions are deprecated. With Apple's decision to [deprecate OpenGL](https://developer.apple.com/macos/whats-new/) this project deprecated the Apple platforms. The files are left for posterity or for the adventerous. Anomalous Medical is a volunteer effort and the decision was made to focus on platforms that offer both openness and stability. The last sucessful Apple platform builds were in 2016.

----------------------------------------------------------

This software was designed and built in sunny Florida, USA.