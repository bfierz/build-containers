# Using Docker for Windows to Build C++ Applications

## Disclaimer

Microsoft does not push any built containers to a public docker registry as the
license requires you to have a valid Visual Studio for your use-case as
mentioned in this
[blog-post](https://devblogs.microsoft.com/cppblog/using-msvc-in-a-docker-container-for-your-c-projects):

> "Remember that the VS Build Tools are licensed as a supplement to your existing
> Visual Studio license. Any images built with these tools should be for your
> personal use or for use in your organization in accordance with your existing
> Visual Studio and Windows licenses. Please don’t share these images on a
> public Docker hub.

## Requirements

As container support or Windows is still relatively new there are still quite a
few bugs around. This setup was successfully tested using:

* Windows 10 1809 or newer
* Docker Desktop CE for Windows 2.2.0.5 with Docker Engine 19.03.8

## Build Container

In order to build the container call docker build. As mentioned in the official
list of [known issues](https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container-issues)
you need to pass `-m 2GB` to install some Visual Studio workloads correctly:

```bat
docker build -t build_tools:latest -m 2GB .
```

The build recipe exposes a number of different argumentes that can be used to
customize the container:

* WINDOWS_IMAGE: Docker image to use as basis. Set this variable if
e.g. Windows Server Core should be used.
* WINDOWS_IMAGE_VERSION: When using process isolation the Windows version of
host and container need to match. This variable required to set the correct
Windows version.
* VISUAL_STUDIO_VERSION: Visual Studio Build Tools version to install.
Currently supported are 2015, 2017 and 2019.

### Adding GPU support

As of [Windows 10 1809 and Windows Server 2019](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/hardware-devices-in-containers),
it is possible to access [the hosts GPU](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/gpu-acceleration)
when running the container in process isolation. The GPU is enabled by adding `--device class/5B45201D-F2F2-4F3B-85BB-30FF1F953599` to the command-line.

## Running examples

The sample *enum_adapters* contains a simple application which lists all the
accessible GPUs. Running the following command from this folder should print
the hosts GPU and the D3D WARP driver, omitting the `--device` parameter should
only print the D3D WARP driver:

```bat
docker run --isolation=process --device class/5B45201D-F2F2-4F3B-85BB-30FF1F953599 -v %CD%\samples:C:\src -it build_tools:latest powershell "mkdir C:\src\enum_adapters\build; cd C:\src\enum_adapters\build; cmake -G 'Visual Studio 15 2017 Win64' ..; cmake --build . --config Debug; .\Debug\enum_adapters"
```
