﻿function Get-NetFramework
{
	<#
	.SYNOPSIS
		This function will retrieve the list of Framework Installed on the computer.
	.EXAMPLE
		Get-NetFramework
	
		PSChildName                                   Version                                      
		-----------                                   -------                                      
		v2.0.50727                                    2.0.50727.4927                               
		v3.0                                          3.0.30729.4926                               
		Windows Communication Foundation              3.0.4506.4926                                
		Windows Presentation Foundation               3.0.6920.4902                                
		v3.5                                          3.5.30729.4926                               
		Client                                        4.5.51641                                    
		Full                                          4.5.51641                                    
		Client                                        4.0.0.0        
	
	.NOTES
		TODO:
			Credential support
			ComputerName
				$hklm = 2147483650
				$key = "SOFTWARE\Microsoft\NET Framework Setup"
				$value = "NDP"
				Get-wmiobject -list "StdRegProv" -namespace root\default -computername . |
				Invoke-WmiMethod -name GetDWORDValue -ArgumentList $hklm,$key,$value | select uvalue
	#>
	
	Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
	Get-ItemProperty -name Version -EA 0 |
	Where-Object { $_.PSChildName -match '^(?!S)\p{L}' } |
	Select-Object -Property PSChildName, Version
	
}