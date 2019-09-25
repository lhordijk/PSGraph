Write-Verbose "Importing Functions"

# Import everything in these folders
ForEach ( $folder in @('private', 'public', 'classes'))
{
        $root = Join-Path -Path $PSScriptRoot -ChildPath $folder
        if(Test-Path -Path $root)
        {
            Write-Verbose "Processing folder $root"
            $files = Get-ChildItem -Path $root -Filter *.ps1

            # dot source each file
            $files | Where-Object { $_.Name -NotLike '*.Tests.ps1'} |
                ForEach-Object { Write-Verbose $_.Name; . $_.FullName }
        }
}

Export-ModuleMember -Function (Get-ChildItem -Path "$PSScriptRoot\public\*.ps1").BaseName
