#Script to create new active directory users
#March 13 2013
#Sean Matheson

#import active direcory module
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

#get domain DNS suffix
$dnsroot = '@' + (Get-ADDomain).dnsroot

#import the file containing new user account data and assign
$users = Import-Csv .\newusers.csv

#iterate over the list
foreach ($user in $users)
{
	$newSamAccountName = $user.Username
	if( -not (Get-ADUser -Filter {SamAccountName -eq $newSamAccountName})) 
	{
		New-ADUser -SamAccountName $user.Username -Name ($user.Firstname + " " + $user.Lastname) `
		-DisplayName ($user.Firstname + " " + $user.Lastname) -GivenName $user.Firstname -Surname $user.Lastname `
		-UserPrincipalName ($user.Username) `
		-Enabled $true -ChangePasswordAtLogon $true -PasswordNeverExpires  $false `
		-AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -force) -PassThru `
		
		echo "-----------------------------------" >> listOfUsers.txt
		echo  $user.Firstname $user.Lastname $user.Username >> listOfUsers.txt
		echo "-----------------------------------" >> listOfUsers.txt
	}
	else
	{
		echo "----------------------------------------------------------------------------------------------------"
		echo The Active directory account $user.Username is already registered to $user.Firstname $user.Lastname
		echo "----------------------------------------------------------------------------------------------------"
		
	}
}