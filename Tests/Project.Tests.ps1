$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path -Path (Resolve-Path "$projectRoot\*\*.psm1")
$moduleName = Split-Path $ModuleRoot -Leaf

Describe "General Project Validation: $moduleName" {

    $scripts = Get-ChildItem $projectRoot -Include *.ps1, *.psm1, *.psd1 -Recurse

    # Testcases are splatted to the script, so we need hashtables
    $testCase = $scripts | ForEach-Object {@{file=$_}}

    It "Script <file> should be valid PowerShell" -TestCases $testCase {
        param($file)

        $file.fullname | Should Exist

        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors.Count | Should Be 0
    }

    It "Module '$moduleName' can import cleanly" {
        { Import-Module (Join-Path $moduleRoot "$moduleName.psm1") -Force } | Should Not Throw
    }
}


