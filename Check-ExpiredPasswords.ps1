#Verificar contas ativas com senhas expiradas (cole o comando abaixo no powershell)

$startDate = Get-Date "2024-01-01"
 
Get-ADUser -Filter * -Properties DisplayName, SamAccountName, PasswordLastSet, msDS-UserPasswordExpiryTimeComputed |
    Where-Object {
        $_.'msDS-UserPasswordExpiryTimeComputed' -lt (Get-Date).ToFileTimeUtc() -and
        [datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed') -ge $startDate
    } |
    Select-Object DisplayName, SamAccountName, PasswordLastSet, @{
        Name = "ExpiresOn"
        Expression = { [datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed') }
    } | Sort-Object ExpiresOn

----------------------------------------------------
#verificar contas ativas cuja senha irá expirar em 10 dias. (cole o comando abaixo no powershell)

$startDate = Get-Date "2024-01-01"
 
Get-ADUser -Filter * -Properties DisplayName, SamAccountName, PasswordLastSet, msDS-UserPasswordExpiryTimeComputed, Enabled |
    Where-Object {
        $_.Enabled -eq $true -and  
        $_.'msDS-UserPasswordExpiryTimeComputed' -lt (Get-Date).ToFileTimeUtc() -and
        [datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed') -ge $startDate
    } |
    Select-Object DisplayName, SamAccountName, PasswordLastSet, @{
        Name = "ExpiresOn"
        Expression = { [datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed') }
    }, Enabled | Sort-Object ExpiresOn
