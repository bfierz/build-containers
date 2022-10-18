docker build --build-arg WINDOWS_IMAGE=mcr.microsoft.com/windows/servercore --build-arg WINDOWS_IMAGE_VERSION=ltsc2022 --build-arg VISUAL_STUDIO_VERSION=2022 -t build_tools:latest -m 2GB .
