$TargetFolder = "C:\main"
$UnLessParam = 1
while ($UnLessParam = 1)
{
	$LastUpdateFile = Get-Childitem $TargetFolder -File -Recurse -exclude *.changed.txt | sort LastWriteTime -Descending | select -First 1
	$LastTimeUpdatedFile = $LastUpdateFile.LastWriteTime.ToString("dd.MM.yyyy HH:mm:ss")
	Do
	{
		$LastUpdateFile = Get-Childitem $TargetFolder -File -Recurse -exclude *.changed.txt | sort LastWriteTime -Descending | select -First 1
		$LastTimeUpdatedFileChanget = $LastUpdateFile.LastWriteTime.ToString("dd.MM.yyyy HH:mm:ss")
	}
	Until ($LastTimeUpdatedFileChanget -ne $LastTimeUpdatedFile)
	$LastTimeUpdatedFile = $LastTimeUpdatedFileChanget
	$NameOfFile = $LastUpdateFile.Name
	$NameOfDeroctory = $LastUpdateFile.DirectoryName
	$objshell = New-Object -ComObject Shell.Application
	$folderObject = $objshell.NameSpace($NameOfDeroctory)
	$fileObject = $folderObject.ParseName($NameOfFile)
	$a = 0
      		for ( $a ; $a  -le 266; $a++ )
       		{ 
         		if( $folderObject.getDetailsOf( $fileObject, $a ))
           		{
             			$InfoAboutFile += @{ $( $folderObject.getDetailsOf( $folderObject.items, $a ))  =
                   		$( $folderObject.getDetailsOf( $fileObject, $a )) }
           		} 
       		}  
	$NameUpdateFile = $LastUpdateFile.BaseName
	$CreationFullName = "$($NameOfDeroctory)\$($NameUpdateFile).changed.txt"
	$InfoAboutFile | Out-File -FilePath $CreationFullName
	$MyRawString = Get-Content -Raw $CreationFullName
	$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
	[System.IO.File]::WriteAllLines($CreationFullName, $MyRawString, $Utf8NoBomEncoding)
	Write-Host "It's working"
	$InfoAboutFile.clear()
}
