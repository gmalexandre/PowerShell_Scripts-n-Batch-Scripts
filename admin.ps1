# THIS SCRIPT IS FOR THE PT-BR langue of windows, in another language, change the groups and usernames to those of your language

# Sets the password for the administrator account, mude "password" para a senha desejada
$senhaAdministrador = ConvertTo-SecureString "password" -AsPlainText -Force

# Activate the administrator account and set the password
Enable-LocalUser -Name "Administrador"
Set-LocalUser -Name "Administrador" -Password $senhaAdministrador -PasswordNeverExpires:$true

# Remove the current account from the Administrators group, change "user" to the current user, if it is orange for example, put -Member "orange"
Remove-LocalGroupMember -Group "Administradores" -Member "user"

# Add the current account to the Users group.
Add-LocalGroupMember -Group "Usuários" -Member "user"

# "Display a message indicating that the process has been completed."
Write-Host "The process has been completed. The administrator account has been activated, and the current account has been demoted to a standard user."