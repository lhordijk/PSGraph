$Module = @{
    Author = 'Leo Hordijk'
    Description = 'GraphViz helper module for generating graph images'
    RootModule = 'PSGraph.psm1'
    Path = 'PSGraph\PSGraph.psd1'
    ModuleVersion = '0.0.1'
}

New-ModuleManifest @module
