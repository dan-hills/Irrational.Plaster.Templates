function Save-ApiSettings{

    <#
    .SYNOPSIS
        This function will configure default parameter settings used when connecting to the Api

    .DESCRIPTION
        This function will configure default parameter settings used when connecting to the Api

    .PARAMETER Credential
        This is a PSCredential object used to access the api

    .EXAMPLE
        PS> 

        This function will save specified parameters to the PS DefaultParameterValues for the current session

    .INPUTS
        No inputs are required. Settings are only saved for specified values

    .OUTPUTS
        No output is expected

    .LINK

    .NOTES
        These settings will only work for the current Powershell session
    #>

    [cmdletbinding()]

    param(
        [Parameter()]
        [PSCredential] $Credential,

        [Parameter()]
        [Switch] $OverwriteDefaults = $false
    )

    BEGIN{}

    PROCESS{

        $commandList = ( Get-Module -Name $moduleName ).exportedCommands.values
        $paramOptions = $PSBoundParameters.keys.where({$_ -notIn @(
                'OverwriteDefaults'
                'Verbose'
                'Debug'
                'ErrorAction'
                'WarningAction'
                'InformationAction'
                'ErrorVariable'
                'WarningVariable'
                'InformationVariable'
                'OutVariable'
                'OutBuffer'
                'PipelineVariable'
            )})
        
        # We will loop through each command to remove/add new default values
        ForEach($command in $commandList.name){
        
            # Remove any default settings that have already been configured
            if( $overwriteDefaults ){

                forEach( $option in $paramOptions ){

                    Write-Verbose "Removing default parameter settings for '$($command):$option'"
                    $global:PSDefaultParameterValues.remove( "$($command):$option" )
                }
            }
    
            # Save default settings on all functions in the module
            forEach( $option in $paramOptions ){

                Write-Verbose ( "Saving settings: {0}:{1}" -f $command,$option )
                Try{

                    $Global:PSDefaultParameterValues += @{ "$($command):$option" = $psBoundParameters["$option"] }
                }
                Catch [System.ArgumentException] {

                    throw "A default parameter for '$option' has already been set for $($command). 
                        `nPlease remove the default parameter values or use the -Overwrite switch to remove existing entries."
                }
                Catch {
                    throw "An unknown error has occurred"
                }
            }
        }
    
        Write-Information "Default settings have been saved for $moduleName" -InformationAction Continue
    
    }

    END{}
}