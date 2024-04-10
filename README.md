# Irrational.Plaster.Templates

### Short Description
This can be used to build a generalized scaffolding of powershell files, folders and tests

### Long Description
Plaster can be used to build a generalized scaffolding of powershell files, folders and tests according to the preferred naming standards and folder structure. Any files which can be generalized and shared across modules have been included or can be added if they are currently missing

### Building a new PS Module Using a Template
Begin a new deployment using:

<code>
Invoke-Plaster -TemplatePath <template-path> -DestinationPath x:\NewModule
</code>

This should then build a structure similar to the following:

```bash
Folder PATH listing for volume DATA
Volume serial number is C0000100 8097:024A
X:.
|   build.ps1
|   psake.ps1
|   README.md
|   TestPlaster.psd1
|   TestPlaster.psm1
|   
+---bin
+---classes
+---demo
+---docs
|       about_TestPlaster.md
|       
+---en-us
+---lib
+---private
+---public
+---scripts
\---tests
        TestPlaster.Tests.ps1
```
