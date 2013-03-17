#Find users in a member group
#March 15 2013
#Sean Matheson

#import active direcory module
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

Get-ADGroupMember "Domain Admins" -recursive | Select-Object name