# Find-VulnerableElectronVersion
Scans an executable and determines if it was wrapped in an Electron version vulnerable to the Chromium vulnerability CVE-2023-4863/ CVE-2023-5217 using the Sysinternals tool Strings.

Requires Sysinternals to be installed: https://learn.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite
Example syntax: Find-VulnerableElectronVersion -AppPath C:\Users\<username>\AppData\Local\Programs\AppName -FileName AppName.exe -StringsPath C:\Users\<username>\Documents\Sysinternals
