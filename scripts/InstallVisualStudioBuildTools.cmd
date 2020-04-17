@echo off
:: A number of helpful resources about installing the build tools:
:: * Official guide: https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container
:: * Advanced example: https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container
:: * Known issues: https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container-issues
:: * Collect error logs: https://devblogs.microsoft.com/setup/installing-build-tools-for-visual-studio-2017-in-a-docker-container/

:: The following blog-post contains a reminer about the licensing:
:: https://devblogs.microsoft.com/cppblog/using-msvc-in-a-docker-container-for-your-c-projects
::
:: "Remember that the VS Build Tools are licensed as a supplement to your existing
:: Visual Studio license. Any images built with these tools should be for your
:: personal use or for use in your organization in accordance with your existing
:: Visual Studio and Windows licenses. Please don’t share these images on a public Docker hub."
echo "Installing Visual Studio %VS_VER%"

if /i %VS_VER%==2015 (
    goto install_vs2015
) else ( 
if /i %VS_VER%==2017 (
    goto install_vs2017
) else ( 
if /i %VS_VER%==2019 (
    goto install_vs2019
)))

:install_vs2015
:: Install Visual Studio Build Tools 2015
:: Announcement about the availability of the 2015 Build Tools:
:: https://devblogs.microsoft.com/cppblog/announcing-visual-c-build-tools-2015-standalone-c-tools-for-build-environments
:: Full download link of the installer:
:: https://download.microsoft.com/download/5/F/7/5F7ACAEB-8363-451F-9425-68A90F98B238/visualcppbuildtools_full.exe
choco install -y visualcpp-build-tools --version=14.0.25420.1
goto:eof

:install_vs2017
:: Install Visual Studio Build Tools 2017
:: List of potential packages are available here:
:: * https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2017
choco install -y visualstudio2017buildtools --force --package-parameters ^"--passive --nocache --noUpdateInstaller --locale en-US^
 --add Microsoft.VisualStudio.Workload.MSBuildTools^
 --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended^
 --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core^
 --add Microsoft.VisualStudio.Component.VC.140^
 --add Microsoft.VisualStudio.Component.VC.Tools.ARM^
 --add Microsoft.VisualStudio.Component.VC.Tools.ARM64^
 --includeRecommended^"
goto:eof

:install_vs2019
:: Install Visual Studio Build Tools 2019
:: List of potential packages are available here:
:: * https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2019
  install -y visualstudio2019buildtools --package-parameters ^"--passive --nocache --noUpdateInstaller --locale en-US^
 --add Microsoft.VisualStudio.Workload.MSBuildTools^
 --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended^
 --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core^
 --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang^
 --add Microsoft.VisualStudio.Component.VC.140^
 --add Microsoft.VisualStudio.Component.VC.v141.x86.x64^
 --add Microsoft.VisualStudio.Component.VC.v141.ARM^
 --add Microsoft.VisualStudio.Component.VC.v141.ARM64^
 --add Microsoft.VisualStudio.Component.VC.CoreIde^
 --add Microsoft.VisualStudio.Component.VC.Llvm.Clang^
 --add Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset^
 --add Microsoft.VisualStudio.Component.VC.Tools.ARM^
 --add Microsoft.VisualStudio.Component.VC.Tools.ARM64^
 --includeRecommended^"
goto:eof
