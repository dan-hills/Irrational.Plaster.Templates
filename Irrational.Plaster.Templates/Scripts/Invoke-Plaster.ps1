<#
.SYNOPSIS 
This is a quick start script to initialize Plaster for all available Templates

.NOTES
This is not needed to invoke Plaster but this might make it a bit easier to use
#>

function SelectTemplate($folderlist) {

    Write-Host "`nPlaster Template List:" -ForegroundColor Cyan
    For( $i = 0; $i -lt $folderlist.count; $i += 1 ){
        
        $file = "{0}\about_{1}.txt" -f $folderlist[$i].fullname,$folderlist[$i].name
        $description = Get-Content $file -ErrorAction SilentlyContinue
        Write-Host "`n[$( $i + 1 )] $( $folderlist.name )" -ForegroundColor Green
        Write-Host "Description: $description`n "
        
    }

    [int]$templatenum = Read-Host -Prompt "Please select a template to begin"

    if( $templatenum -lt ( $folderlist.count + 1) -AND $templatenum -gt 0 ){
        $templatepath = $folderlist[($templatenum -1)].fullname
    }
    else{
        throw "That is not a valid template selection"
        $templatepath = SelectTemplate $folderlist
    }
    $templatepath
}

# Retrieve the contents of the templates folder
$folderlist = Get-ChildItem -Path "$( Split-Path -Path $psscriptroot )\Templates"

$templatepath = SelectTemplate $folderlist

Invoke-Plaster -TemplatePath $templatepath
