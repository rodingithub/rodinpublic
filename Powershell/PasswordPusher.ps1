﻿<#
.SYNOPSIS
Pushes the password to pwpush.com and retrieves the link.
.DESCRIPTION
The idea behind the https://pwpush.com is to create links with password which will expire after specific time - therefore password are not left in clear text in email forever.
The Push-PWPush will generate the link with the password provided, or will generate random number as the password, if no password is provided.
.NOTES
Password requires Internet Explorer to work. Things which are going to be added:
- More sophisticate random password
- Customised settings for random password
.PARAMETER password
Passsword which is going to be pushed. If no value is provided, random password will be generated.
.PARAMETER expire
Number of days after which the link expires. Default value is 7 days. Allowed values: 1-90
.PARAMETER views
Number of views after which the link expires. Default value is 5 views. Allowed values: 1-100
.EXAMPLE 
Generates a random password with default settings.
.\Get-PasswordLink.ps1
.EXAMPLE
Pushes password "Passw0rd!" which will expire either after 14 days or 2 views, whichever comes sooner.
.\Get-PasswordLink.ps1 -Password Passw0rd! -Expire 14 -Views 2
#>
[CmdletBinding()]

Param(
    [Parameter(Position=1,Mandatory=$true)]
    [AllowEmptyString()]
    [string]$Password,
    
    [ValidateRange(1,90)]
    [string]$Expire = 3,

    [ValidateRange(1,100)]
    [string]$Views  = 1
    )

If (!$Password) {[string]$Password = (Get-Random)}

Write-Host "Using password: $Password"

$IE = New-Object -ComObject "InternetExplorer.Application"

$RequestURI = "https://otp.rodin.com.au"

$IE.Visible = $false
$IE.Silent = $true
$IE.Navigate($RequestURI)

While ($IE.Busy) {Start-Sleep -Seconds 1}

$Payload        = "password_payload"
$ExpireID       = "password_expire_after_days"
$ViewsID        = "password_expire_after_views"

$Doc = $IE.Document
$Doc.getElementsByTagName("input") | ForEach-Object {
    if ($_.id -ne $null){
        if ($_.id.contains($Payload)) {$Payload = $_}
        if ($_.id.contains($ExpireID)) {$ExpireID = $_}
        if ($_.id.contains($ViewsID)) {$ViewsID = $_}
    }
    if ($_.name -ne $null){
        if ($_.name.contains($commit)) {$SubmitButton = $_}
    }
}

$Payload.value  =   $Password
$ExpireID.value =   $Expire
$ViewsID.value  =   $Views
#Start-sleep -Seconds 1
$SubmitButton.click()

While ($IE.Busy) {Start-Sleep -Seconds 1}

$URL = "url"

$Doc.getElementsByTagName("input") | ForEach-Object {
    if ($_.id -ne $null){
        if ($_.id.contains($URL)) {$URL = $_}
    }
}

Set-Clipboard -Value $URL.value