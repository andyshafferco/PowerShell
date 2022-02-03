$Folder = Read-Host -Prompt 'Enter the full path to the target folder tree to delete'
$Days = Read-Host -Prompt 'Delete files older than (in days)'

#Delete files older than $Days
    Get-ChildItem $Folder -Recurse -Force -ea 0 |
    Where-Object {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-$Days)} |
    ForEach-Object {
       $_ | Remove-Item -Force
       $_.FullName | Out-File C:\deleteditems.txt -Append
    }

    #Delete empty folders and subfolders
    Get-ChildItem $Folder -Recurse -Force -ea 0 |
    Where-Object {$_.PsIsContainer -eq $True} |
    Where-Object {$_.getfiles().count -eq 0} |
    ForEach-Object {
        $_ | Remove-Item -Force
        $_.FullName | Out-File C:\deleteditems.txt -Append
    }