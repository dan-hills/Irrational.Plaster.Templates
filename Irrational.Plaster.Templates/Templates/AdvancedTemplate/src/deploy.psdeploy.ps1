 # Set-BuildEnvironment from BuildHelpers module has populated ENV:BHProjectName

# Publish to gallery with a few restrictions
if(
    $env:BHProjectName -and $env:BHProjectName.Count -eq 1 -and
    $env:BHBuildSystem -ne 'Unknown' -and
    $env:BHBranchName -eq "master" -and
    $env:BHCommitMessage -match '!deploy'
)
{
    Deploy MyModule {
        By PlatyPS {
            FromSource "$env:BHProjectName\docs"
            To "$env:BHProjectName\en-US"
            Tagged Help, Module
            WithOptions @{
                Force = $true
            }
        }
    }
}