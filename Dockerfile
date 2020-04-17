# escape=`

# A lot of pitfalls and things that could go wrong when building containers
# on windows can be found here:
# https://jfreeman.dev/blog/2019/07/09/what-i-learned-making-a-docker-container-for-building-c++-on-windows/

# Keep the exact Windows version outside of the dockerfile in order to all the
# possibility set the correct version, or switch the Windows image type.
# The version numbers of individual Windows 10 releases are documented here:
# https://docs.microsoft.com/en-us/windows/release-information
# A list of images can be found here:
# https://hub.docker.com/_/microsoft-windows
ARG WINDOWS_IMAGE=mcr.microsoft.com/windows
ARG WINDOWS_IMAGE_VERSION=10.0.18363.720
FROM ${WINDOWS_IMAGE}:${WINDOWS_IMAGE_VERSION}

# Label the Windows version for external identification
LABEL Windows.Version = ${WINDOWS_IMAGE_VERSION}

# Reset the shell.
SHELL ["powershell", "-NoLogo", "-ExecutionPolicy", "Bypass", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]

# Setup chocolatey
ADD scripts\* C:\Temp\
RUN C:\Temp\InstallChocolatey.ps1

# Install generic development software
RUN C:\Temp\InstallDevPackages.ps1

# Reset the shell. Visual Studio Build Tools don't install well under PowerShell.
# The CMD parameters /S and /C need to go together with --quiet and --wait from
# the Visual Studio Build Tools installer.
SHELL ["cmd", "/S", "/C"]

# Install Visual Studio
ARG VISUAL_STUDIO_VERSION=2017
ENV VS_VER=${VISUAL_STUDIO_VERSION}
RUN C:\Temp\InstallVisualStudioBuildTools.cmd

# Switch back to PowerShell
SHELL ["powershell", "-NoLogo", "-ExecutionPolicy", "Bypass", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]

# Make changes to path variable visible
RUN refreshenv

# Cleanup
RUN Remove-Item C:\Temp -Recurse -Force

# Start PowerShell if no other command specified
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
