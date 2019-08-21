<# 
	This PowerShell script was automatically converted to PowerShell Workflow so it can be run as a runbook.
	Specific changes that have been made are marked with a comment starting with “Converter:”
#>
<#
.SYNOPSIS 

    This workflow runs an ARM template and parameter files that are stored online

.DESCRIPTION 

    This wrokflow requires a vlaue for the resource group towards which the deployment will run to. If your files are stored
    in a private blob container, make sure to append your SAS token.

.PARAMETER 

            DeploymentName - Name for the deployment.
            RGName - Name of the resource group for the deployment.
            TemplateURI - URL for the location of the ARM template. If needed, append the necessary SAS token.
            ParameterFileURI - URL for the location of the ARM template parameter file. If needed, append the necessary SAS token.

.Notes

    Author: G.Tuttolomondo
    Last Update: 24/9/2018

#>

workflow ArmTemplateDeploymentWorkflow {
	Param(
    [string]$RGName = "Primary-Resource-Group",
    [string]$DeploymentName = "deploy02",
    [string]$TemplateUri = "https://reportaccount.blob.core.windows.net/vm-report-blob/template.json",
    [string]$TemplateParametersURI = "https://reportaccount.blob.core.windows.net/vm-report-blob/parameters.json"
    )
	    		
    $Conn = Get-AutomationConnection -Name AzureRunAsConnection 
    Add-AzureRMAccount -ServicePrincipal -TenantId $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
        		
    #New-AzureRmResourceGroupDeployment -Mode incremental -ResourceGroupName $RGName -Name $DeploymentName -TemplateUri https://reportaccount.blob.core.windows.net/vm-report-blob/template.json -TemplateParameterURI https://reportaccount.blob.core.windows.net/vm-report-blob/parameters.json -verbose
    New-AzureRmResourceGroupDeployment -Mode incremental -ResourceGroupName $RGName -Name $DeploymentName -TemplateUri $TemplateUri -TemplateParameterURI $TemplateParametersURI -verbose
		

}