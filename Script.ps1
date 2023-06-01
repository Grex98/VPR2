$TargetFolder = "C:\main"
$UnLessParam = 1
while ($UnLessParam = 1)
{
	$LastUpdateFile = Get-Childitem $TargetFolder -File -Recurse | sort LastWriteTime -Descending | select -First 1
	$LastTimeUpdatedFile = $LastUpdateFile.LastWriteTime.ToString("dd.MM.yyyy HH:mm:ss")
	Do
	{
		$LastUpdateFile = Get-Childitem $TargetFolder -File -Recurse | sort LastWriteTime -Descending | select -First 1
		$LastTimeUpdatedFileChanget = $LastUpdateFile.LastWriteTime.ToString("dd.MM.yyyy HH:mm:ss")
	}
	Until ($LastTimeUpdatedFileChanget -ne $LastTimeUpdatedFile)
	$LastTimeUpdatedFile = $LastTimeUpdatedFileChanget
	$FolderOfLastUpdatedFile = $LastUpdateFile.fullName
	$InfoAboutFile = Get-ChildItem $FolderOfLastUpdatedFile | Format-List -Property * 
	$InfoAboutFile
	$DirectoryLastUpdateFile = $LastUpdateFile.DirectoryName
	$NameUpdateFile = $LastUpdateFile.BaseName
	$CreationFullName = "$($DirectoryLastUpdateFile)\$($NameUpdateFile).changed.txt"
	Get-Childitem $FolderOfLastUpdatedFile | Format-List -Property * | Out-File -FilePath $CreationFullName
	Write-Host "It's working"
	
}