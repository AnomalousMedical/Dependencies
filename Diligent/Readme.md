# Diligent Engine

## Install Vulkan SDK
https://vulkan.lunarg.com/sdk/home

## Visual Studio Requirements
Make sure to install `C++ Desktop Development`. You need ATL, which should be included there.

## Windows Python
You will need Python in the same folder as the Dependencies folder in a folder called Python. Just download and extract to there. Any 3+ version seems ok. Errors during cmake are probably because of this.

## Project build failure
One of the projects `DiligentCore-ValidateFormatting` won't build, but this doesn't prevent anything from working. Seems to want to call something with Python, but I don't have python actually installed.

## Dirty repo after build
The file File2String.exe will be modified during build. Just revert it after building to clear the changes.

## Backup Git Repo
There is a backup git repo of all the files that worked for a given version of diligent. This flattens out the subrepos into one.
To update it:
 1. Clone
 2. Erase all existing files except git
 3. Make copy of DiligentCore from this folder.
 4. Run `Get-ChildItem -Path . -Include .git -Recurse -Hidden | Remove-Item -WhatIf` to erase the .git files from that repo.
 5. Copy these files into the dest repo.