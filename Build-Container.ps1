$tag = helpers\Select-Image.ps1 -Image windows
docker build --build-arg WINDOWS_IMAGE=mcr.microsoft.com/windows --build-arg WINDOWS_IMAGE_VERSION=$tag --build-arg VISUAL_STUDIO_VERSION=2017 -t build_tools:latest -m 2GB .
