function Find-VulnerableElectronVersion {
    ## Requires Sysinternals to be installed: https://learn.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite
    ## Example syntax: Get-ElectronVersion -AppPath C:\Users\<username>\AppData\Local\Programs\ClickUp -AppName ClickUp.exe -StringsPath C:\Users\<username>\Documents\Sysinternals
    param (
        [Parameter(Mandatory = $true)][String]$AppPath,
        [Parameter(Mandatory = $true)][String]$FileName,
        [Parameter(Mandatory = $true)][String]$StringsPath
    )

    try {
        $payload = $StringsPath + "\strings.exe " + $AppPath + "\" + $FileName + ' | findstr /l /c:"Electron v" 2>nul'
        Write-Host "Checking executable for a vulnerable Electron version. Please allow up to 2 minutes to finish scanning..."
        cmd.exe /c $payload | Tee-Object -Variable stringsOutput
        $checkElectron = $stringsOutput.Contains("Electron")
        $checkVer = $stringsOutput.Contains("26")
    
        if ( $checkElectron -eq $true ) {
            if ( $checkVer -eq $true ) {
                Write-Host "This application is using a version of Electron that is safe from CVE-2023-4863. Electron version: $stringsOutput"
            } else {
                Write-Host "This application is using a version of Electron that is vulnerable to CVE-2023-4863. It is recommended to either update this application or use it in a fully up-to-date web browser."
            }
        } else {
            Write-Host "Electron version not found. Make sure you're scanning the right file: $AppPath\$FileName"
        }    
    } catch {
        Write-Host "Unexpected error occurred. Please make sure your Strings and Electron app directories are correct and try again."
    }
}