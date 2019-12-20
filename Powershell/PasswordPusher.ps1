Add-Type -AssemblyName Microsoft.VisualBasic
[string]$Password = [Microsoft.VisualBasic.Interaction]::InputBox("Enter a password", "Password", "")


[string]$Expire = 7
[string]$Views  = 1


If(!$Password) {[string]$Password = (Get-Random)}

Write-Host "Using password: $Password"

$IE = New-Object -ComObject "InternetExplorer.Application"

$RequestURI = "https://otp.rodin.com.au"

$IE.Visible = $false
$IE.Silent = $true
$IE.Navigate($RequestURI)

While ($IE.Busy) {Start-Sleep -Seconds 1}

$Payload  = "password_payload"
$ExpireID = "password_expire_after_days"
$ViewsID = "password_expire_after_views"

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

$Payload.value  = $Password
$ExpireID.value = $Expire
$ViewsID.value  = $Views
#Start-sleep -Seconds 1
$SubmitButton.click()

While ($IE.Busy) {Start-Sleep -Seconds 1}

$URL = "url"

$Doc.getElementsByTagName("input") | ForEach-Object {
    if ($_.id -ne $null){
        if ($_.id.contains($URL)) {$URL = $_}
    }
}

while((Get-Clipboard) -ne $URL.value){
Set-Clipboard -Value $URL.value
[Microsoft.VisualBasic.Interaction]::MsgBox("Link copied to clipboard", "OKOnly", "Password")

}