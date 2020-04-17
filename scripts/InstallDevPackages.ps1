# Make 'refreshenv' available
$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."
Import-Module -Name "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# Setup generic system packages
choco install -y 7zip.install
choco install -y python --version=3.8.2

# Make changes to path variable visible
refreshenv

# Install python pip
curl https://bootstrap.pypa.io/get-pip.py -o C:\Temp\get-pip.py
python C:\Temp\get-pip.py

# Make changes to path variable visible
refreshenv

# Setup base development packages
choco install -y git.install
choco install -y git-lfs.install

# C++ specific packages
choco install -y cmake.install --installargs "ADD_CMAKE_TO_PATH=System"
choco install -y ninja
choco install -y doxygen.install
choco install -y opencppcoverage
choco install -y llvm

# Setup the conan package manager
pip install conan

# Make changes to path variable visible
refreshenv
