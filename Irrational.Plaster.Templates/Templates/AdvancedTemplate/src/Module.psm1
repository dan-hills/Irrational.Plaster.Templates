#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$Classes = @( Get-ChildItem -Path $PSScriptRoot\classes\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach($import in @($Public + $Private + $Classes))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Export the Public modules
Export-ModuleMember -Function $Public.Basename

# Export Alias Commands
#New-Alias -Name MyAlias -Value Get-MyCommand
#Export-ModuleMember -Alias 'MyAlias'

# Configured Module Variables
$moduleName = '<%=$PLASTER_PARAM_ModuleName%>'
#$moduleVariable = 'myVariable'
