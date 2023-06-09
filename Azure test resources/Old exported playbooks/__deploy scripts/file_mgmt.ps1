# # Powershell loop through folders, create file in each folder
# Get-ChildItem -Recurse -Directory | ForEach-Object { New-Item -ItemType file -Path "$($_.FullName)" -Name "$($_.Name).json" }

# # look at all files with given extension in directory (including those in subfolders)
# $extension = ".json"
# # $scriptHome = Split-Path $PSScriptRoot
# # $targetDirectory = $PSScriptRoot
# $targetDirectory = (Get-Item $(pwd)).Parent.FullName


# function Get-FilesbyExtension($directory, $extension, $keyword) {
# Get-ChildItem $directory -Filter *$extension |
#     ForEach-Object {
#         $content = Get-Content $_.FullName

#         $content | Where-Object {$_ -match $keyword} | Set-Content {$_.BaseName + '_results.txt'}
#     }
# }

# Get-FilesbyExtension($targetDirectory, $extension, $keyword)
# `````````````````````````````````````````````````````````````````

$targetDirectory = (Split-Path $PSScriptRoot)

$files = Get-ChildItem $targetDirectory


ForEach-Object ($f in $files){
    $outfile = $f.FullName + 'out'
    Get-Content $f.FullName | Where-Object { $_ -match 'playbook' } | Set-Content $outfile
}