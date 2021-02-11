# Diligent Engine

## Windows Python
You will need Python in the same folder as the Dependencies folder in a folder called Python. Just download and extract to there. Any 3+ version seems ok. Errors during cmake are probably because of this.

## Project build failure
One of the projects `DiligentCore-ValidateFormatting` won't build, but this doesn't prevent anything from working. Seems to want to call something with Python, but I don't have python actually installed.

## Dirty repo after build
The file File2String.exe will be modified during build. Just revert it after building to clear the changes.