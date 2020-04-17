# Force usage of Windows compression as Chocolatey is installed on an empty container
$env:chocolateyUseWindowsCompression = 'true'

# Download and install chocolatey.
# The following link contains an alternative installation path if TLS 1.0 should be disabled
# https://amionrails.wordpress.com/2018/02/20/how-to-install-chocolatey-inside-windows-container
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Disable progress bar for usage in docker
choco feature disable -n showDownloadProgress

# Set the cache location for later deletion
choco config set cacheLocation C:/Temp/ChocoCache

# From: https://stackoverflow.com/a/46760714
# Make `refreshenv` available right away, by defining the $env:ChocolateyInstall
# variable and importing the Chocolatey profile module.
# Note: Using `. $PROFILE` instead *may* work, but isn't guaranteed to.
$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."
Import-Module -Name "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# refreshenv is now an alias for Update-SessionEnvironment
# (rather than invoking refreshenv.cmd, the *batch file* for use with cmd.exe)
# This should make an new exe accessible via the refreshed $env:PATH, so that it
# can be called by name only.
refreshenv
