param (
    [string]$Image = "windows"
)

$result = Invoke-WebRequest -Uri "https://mcr.microsoft.com/v2/$Image/tags/list"
$json_result = ConvertFrom-Json -InputObject $result.Content
$tags = $json_result.tags.split()

$os_ver = [System.Environment]::OSVersion.Version
$os_ver_major = $os_ver.Major
$os_ver_minor = $os_ver.Minor
$os_ver_build = $os_ver.Build
$selected_tag = $tags | Where-Object {$_ -match "^$os_ver_major\.$os_ver_minor\.$os_ver_build\.\d+$"} | Select-Object -Last 1
Return $selected_tag
