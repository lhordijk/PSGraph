Param(
    [string] $Task = 'Default'
)

# Grab the NuGet bits, Install modules, Set build variables, start the build
Get-PackageProvider -Name NuGet -ForceBootstrap

Install-Module PSake, PSDeploy, BuildHelpers -Force -Scope CurrentUser
Install-Module Pester -Force -SkipPublisherCheck -Scope CurrentUser

Import-Module PSake, BuildHelpers

Set-BuildEnvironment

Invoke-PSake -BuildFile .\psake.ps1 -taskList $Task -NoLogo
Exit ( [int]( -not $psake.build_success ))