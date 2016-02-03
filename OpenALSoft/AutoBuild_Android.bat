call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"
set PATH=%PATH%;%ANDROID_NDK%

pushd %~dp0
cd srcAndroid\jni
call ndk-build APP_ABI="armeabi-v7a x86" clean
call ndk-build APP_ABI="armeabi-v7a x86" -j
cd ../..
popd