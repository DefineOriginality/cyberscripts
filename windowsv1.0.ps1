Write-Host "Remote Desktop" -ForegroundColor Green

# Disable Remote Assistance
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Value 0
Write-Host "Remote Assistance Disabled" -ForegroundColor Green

# Disable Remote Desktop
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 1
Write-Host "Remote Desktop Disabled" -ForegroundColor Green

# Disable Remote Desktop firewall rules
Disable-NetFirewallRule -DisplayGroup "Remote Desktop"
Write-Host "Remote Desktop Firewall Rules Disabled" -ForegroundColor Green

Write-Host "Firewall" -ForegroundColor Green

# Enable Windows Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
Write-Host "Windows Firewall Enabled" -ForegroundColor Green

Write-Host "Windows Features" -ForegroundColor Green

# Disable Telnet Client
Disable-WindowsOptionalFeature -Online -FeatureName TelnetClient -NoRestart
Write-Host "Telnet Client Disabled" -ForegroundColor Green

# Disable Telnet Server
Disable-WindowsOptionalFeature -Online -FeatureName TelnetServer -NoRestart
Write-Host "Telnet Server Disabled" -ForegroundColor Green

# Disable RIP Listener
Disable-WindowsOptionalFeature -Online -FeatureName RIPListener -NoRestart
Write-Host "RIP Listener Disabled" -ForegroundColor Green

# Disable Simple TCP/IP Services
Disable-WindowsOptionalFeature -Online -FeatureName SimpleTCP -NoRestart
Write-Host "Simple TCP/IP Services Disabled" -ForegroundColor Green

# Disable SMB 1.0
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart
Write-Host "SMB 1.0 Disabled" -ForegroundColor Green

# Enable SMBv3
Set-SmbServerConfiguration -EnableSMB3Protocol $true -Force
Write-Host "SMBv3 Enabled" -ForegroundColor Green

# Disable SMBv1
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
Write-Host "SMBv1 Disabled" -ForegroundColor Green

Write-Host "Autoplay" -ForegroundColor Green

# Disable AutoPlay on all drives
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Value 255
Write-Host "AutoPlay Disabled on All Drives" -ForegroundColor GreenSet

Write-Host "Passwords" -ForegroundColor Green

# Set Password History
net accounts /uniquepw:10
Write-Host "Password History Set To 10" -ForegroundColor Green

# Set Minimum Password Length
net accounts /minpwlen:14
Write-Host "Minimum Password Length Set To 14" -ForegroundColor Green

# Set Maximum Password Age
net accounts /maxpwage:90
Write-Host "Maximum Password Age Set To 90 Days" -ForegroundColor Green

# Set Minimum Password Age
net accounts /minpwage:30
Write-Host "Minimum Password Age Set To 30 Days" -ForegroundColor Green

# Set Account Lockout Threshold
net accounts /lockoutthreshold:10
Write-Host "Account Lockout Threshold Set To 10" -ForegroundColor Green

# Set Account Lockout Duration
net accounts /lockoutduration:30
Write-Host "Account Lockout Duration Set To 30 Mins" -ForegroundColor Green

# Set Reset Lockout Counter
net accounts /lockoutwindow:30
Write-Host "Reset Account Lockout Counter Set To 30 Mins" -ForegroundColor Green

Write-Host "Audits" -ForegroundColor Green

#Set Audits to Success;Failure
auditpol /set /category:* /success:enable /failure:enable
Write-Host "Audits set to Success;Failure" -ForegroundColor Green

Write Host "Security Options" -ForegroundColor Green

# Require CTRL+ALT+DEL
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableCAD" -Value 0
Write-Host "Do Not Require CTRL+ALT+DEL Disabled" -ForegroundColor Green

# Clear Virtual Memory Pagefile On Shutdown
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown" -Value 1
Write-Host "Virtual Memory Pagefile Cleared On Shutdown" -ForegroundColor Green

# Prevent Anonymous Enumeration Of SAM Accounts
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RestrictAnonymousSAM" -Value 1
Write-Host "Anonymous Enumeration Of SAM Accounts Disabled" -ForegroundColor Green

# Limit Blank Passwords To Console Logon Only
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "LimitBlankPasswordUse" -Value 1
Write-Host "Blank Passwords Limited To Console Logon Only" -ForegroundColor Green

# Require Digitally Signed SMB Communications
Set-SmbServerConfiguration -RequireSecuritySignature $true -Force
Write-Host "SMB Digital Signatures Required" -ForegroundColor Green

Write-Host "gpedit stuff" -ForegroundColor Green

# Disable Cortana
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0
Write-Host "Cortana Disabled" -ForegroundColor Green

Write-Host "Services" -ForegroundColor Green

# Windows Update Service - Automatic
Set-Service "wuauserv" -StartupType Automatic
Start-Service "wuauserv"
Write-Host "Windows Update Enabled And Set To Automatic" -ForegroundColor Green

# Windows Firewall Service - Automatic
Set-Service "mpssvc" -StartupType Automatic
Start-Service "mpssvc"
Write-Host "Windows Firewall Enabled And Set To Automatic" -ForegroundColor Green

# Windows Defender Service - Automatic
Set-Service "WinDefend" -StartupType Automatic
Start-Service "WinDefend"
Write-Host "Windows Defender Enabled And Set To Automatic" -ForegroundColor Green

# Remote Desktop Services - Disabled
Stop-Service "TermService" -Force -ErrorAction SilentlyContinue
Set-Service "TermService" -StartupType Disabled
Write-Host "Remote Desktop Services Disabled" -ForegroundColor Green

# IP Helper - Disabled
Stop-Service "iphlpsvc" -Force -ErrorAction SilentlyContinue
Set-Service "iphlpsvc" -StartupType Disabled
Write-Host "IP Helper Disabled" -ForegroundColor Green

# TCP/IP NetBIOS Helper - Disabled
Stop-Service "lmhosts" -Force -ErrorAction SilentlyContinue
Set-Service "lmhosts" -StartupType Disabled
Write-Host "TCP/IP NetBIOS Helper Disabled" -ForegroundColor Green

# Windows Defender Firewall - Automatic
Set-Service "mpssvc" -StartupType Automatic
Start-Service "mpssvc"
Write-Host "Windows Defender Firewall Set To Automatic" -ForegroundColor Green

# Base Filtering Engine - Automatic
Set-Service "BFE" -StartupType Automatic
Start-Service "BFE"
Write-Host "Base Filtering Engine Set To Automatic" -ForegroundColor Green

# Microsoft Defender Antivirus - Automatic
Set-Service "WinDefend" -StartupType Automatic
Start-Service "WinDefend"
Write-Host "Microsoft Defender Antivirus Set To Automatic" -ForegroundColor Green

# Windows Update - Automatic
Set-Service "wuauserv" -StartupType Automatic
Start-Service "wuauserv"
Write-Host "Windows Update Set To Automatic" -ForegroundColor Green

# Windows Event Log - Automatic
Set-Service "EventLog" -StartupType Automatic
Start-Service "EventLog"
Write-Host "Windows Event Log Set To Automatic" -ForegroundColor Green

# Security Center - Automatic (Delayed Start)
Set-Service "wscsvc" -StartupType Automatic
Start-Service "wscsvc"
Write-Host "Security Center Set To Automatic (Delayed Start)" -ForegroundColor Green

# Remote Registry - Disabled
Stop-Service "RemoteRegistry" -Force -ErrorAction SilentlyContinue
Set-Service "RemoteRegistry" -StartupType Disabled
Write-Host "Remote Registry Disabled" -ForegroundColor Green

# Telnet Server - Disabled
Stop-Service "TlntSvr" -Force -ErrorAction SilentlyContinue
Set-Service "TlntSvr" -StartupType Disabled
Write-Host "Telnet Server Disabled" -ForegroundColor Green

# Remote Desktop Services - Disabled
Stop-Service "TermService" -Force -ErrorAction SilentlyContinue
Set-Service "TermService" -StartupType Disabled
Write-Host "Remote Desktop Services Disabled" -ForegroundColor Green

# SNMP Service - Disabled
Stop-Service "SNMP" -Force -ErrorAction SilentlyContinue
Set-Service "SNMP" -StartupType Disabled
Write-Host "SNMP Service Disabled" -ForegroundColor Green

# OpenSSH SSH Server - Disabled
Stop-Service "sshd" -Force -ErrorAction SilentlyContinue
Set-Service "sshd" -StartupType Disabled
Write-Host "OpenSSH SSH Server Disabled" -ForegroundColor Green

# Print Spooler - Disabled
Stop-Service "Spooler" -Force -ErrorAction SilentlyContinue
Set-Service "Spooler" -StartupType Disabled
Write-Host "Print Spooler Disabled" -ForegroundColor Green

# Microsoft FTP Service - Disabled
Stop-Service "FTPSVC" -Force -ErrorAction SilentlyContinue
Set-Service "FTPSVC" -StartupType Disabled
Write-Host "Microsoft FTP Service Disabled" -ForegroundColor Green

# World Wide Web Publishing Service - Disabled
Stop-Service "W3SVC" -Force -ErrorAction SilentlyContinue
Set-Service "W3SVC" -StartupType Disabled
Write-Host "World Wide Web Publishing Service Disabled" -ForegroundColor Green

# Simple TCP/IP Services - Disabled
Stop-Service "simptcp" -Force -ErrorAction SilentlyContinue
Set-Service "simptcp" -StartupType Disabled
Write-Host "Simple TCP/IP Services Disabled" -ForegroundColor Green

# UPnP Device Host - Disabled
Stop-Service "upnphost" -Force -ErrorAction SilentlyContinue
Set-Service "upnphost" -StartupType Disabled
Write-Host "UPnP Device Host Disabled" -ForegroundColor Green

# SSDP Discovery - Disabled
Stop-Service "SSDPSRV" -Force -ErrorAction SilentlyContinue
Set-Service "SSDPSRV" -StartupType Disabled
Write-Host "SSDP Discovery Disabled" -ForegroundColor Green

# Internet Connection Sharing - Disabled
Stop-Service "SharedAccess" -Force -ErrorAction SilentlyContinue
Set-Service "SharedAccess" -StartupType Disabled
Write-Host "Internet Connection Sharing Disabled" -ForegroundColor Green
