########################################################
#Name: RemoveDsToScdpm.ps1                             #
#Creator: Michael Godfrey                              #
#CreationDate: 12.10.2020                              #
#LastModified:01.12.2021                               #
#Version: 1.1                                          #
#                                                      #
########################################################



Param(
[Parameter (Position=0,mandatory)]
[string] $Protectiongroup,
[Parameter (Position=1,mandatory)] 
[string] $DPMServer

) #endparam


#Get-Module -ListAvailable
Import-Module DataProtectionManager

#Variables
If ($Protectiongroup -eq "Null" ) {
Read-Host "What is the name of the Protection Group you want to delete all child sources from?"

}

else {Write-Host $Protectiongroup}


If ($DPMServer -eq "Null") {
Read-Host "What is the name of the Protection Group you want to delete all child sources from?"

}

else {Write-Host $DPMServer}

#Funtional Portion



$PG=Get-DPMProtectionGroup -DPMServerName $DPMServer | where Name -eq $Protectiongroup
Write-Information $PG


$PS=Get-ProductionServer $DPMServer | where ServerName -eq $Server
Write-Information $PS


$DS=Get-DPMDatasource -ProtectionGroup $PG 
Write-Information $ds


$childitems=@()

ForEach ($item in $ds) {$childitems+=$item}

Write-Information "These $($childitems.computer) will be removed from the protection group named $pg"

ForEach ($i in $childitems) {$mpg=Get-ModifiableProtectionGroup $pg ;Remove-DPMChildDatasource -ProtectionGroup $pg -ChildDatasource $i -KeepDiskData -KeepOnlineData -Verbose; Set-ProtectionGroup $MPG}






