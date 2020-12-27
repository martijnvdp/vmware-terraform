$packerurls = "https://releases.hashicorp.com/packer/1.6.6/packer_1.6.6_windows_amd64.zip","https://github.com/rgl/packer-provisioner-windows-update/releases/download/v0.10.1/packer-provisioner-windows-update_0.10.1_windows_amd64.zip"
$terraformurl="https://releases.hashicorp.com/terraform/0.14.3/terraform_0.14.3_windows_amd64.zip"
$toolsdir="c:\tools"
mkdir $toolsdir\terraform
mkdir $toolsdir\packer
foreach ($url in $packerurls){
curl $url -o $toolsdir\packer\packer.zip
Expand-Archive $toolsdir\packer\packer.zip $toolsdir\packer
}
curl $terraformurl -o $toolsdir\terraform\terraform.zip 
Expand-Archive $toolsdir\terraform\terraform.zip $toolsdir\terraform
Get-ChildItem $toolsdir -Recurse -File -Filter *.zip|rm
if (!$env:path -contains "$toolsdir\terraform"){
[Environment]::SetEnvironmentVariable(
    "Path",
    [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";$toolsdir\terraform",
    [EnvironmentVariableTarget]::Machine)
}
if (!$env:path -contains "$toolsdir\packer"){
    [Environment]::SetEnvironmentVariable(
        "Path",
        [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";$toolsdir\packer",
        [EnvironmentVariableTarget]::Machine)
    }