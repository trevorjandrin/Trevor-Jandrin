function Send_Mail{
    Param(
        #parameters for subject and body of email
    [string]$subject,
    [string]$body

    )
    #imports mimekit and mailkit to use
Add-type -path "C:\Program Files\PackageManagement\NuGet\Packages\MimeKit.4.7.1\lib\netstandard2.1\MimeKit.dll"
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\MailKit.4.7.1.1\lib\netstandard2.1\MailKit.dll"
#creates mailkit object names smtp
$SMTP=New-Object MailKit.Net.Smtp.SmtpCLient
#creates message object using mimekit
$Message=New-Object MimeKit.MimeMessage
$Builder=New-Object MimeKit.BodyBuilder
#imports .xml file for account info
#Get-Credential|Import-Clixml -Path C:\Users\tjandrin\Desktop\Powershell\IFM\outlook.xml
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$Account=Import-Clixml -Path $DesktopPath
$Message.From.add("james367232@gmail.com")
$Message.to.add("bob367232@gmail.com")
#addes subject
$Message.Subject=$subject
#adds body
$Builder.TextBody=$body
$Message.Body=$builder.ToMessageBody()
#connects to gmail server and uses port 587
$SMTP.Connect('smtp.gmail.com',587,$false)
$SMTP.Authenticate($Account)
$SMTP.Send($Message)
$SMTP.Disconnect($true)
$SMTP.Dispose()
}

function main
{
    #script for sensors methods
. .\IFM.ps1
#gets sensor data
$body=get_silo_data
#gets current date
$Date=(Get-Date -Format "MM/dd/yyyy").ToString()
$Time=[int](Get-Date -format "hh")
$AMPM=(Get-Date -Format "tt").ToString()
#creats subject line using current date
$subject="$($Date) RENEW Green Bay Silo Data $($Time):00 $($AMPM)"
#sends mail using subject and body
Send_Mail -subject $subject -body $body
}
#call main function
main