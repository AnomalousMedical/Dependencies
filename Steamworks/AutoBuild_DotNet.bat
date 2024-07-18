set ThisFolder=%~dp0
set RootDependencyFolder=%ThisFolder%..\
set CurrentDirectory=%CD%

set SolutionPath=%ThisFolder%Steamworks.Net/Standalone

pushd "%SolutionPath%"

dotnet build -t:BatchBuild Steamworks.NET.Standard.sln

popd