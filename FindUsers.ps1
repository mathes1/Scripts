Import-Module ActiveDirectory -ErrorAction SilentlyContinue

$s = New-Object DirectoryServices.DirectorySearcher

$s.Filter = "((&objectcategory=Person)(objectclass=User))"

$list = $s.FindAll()


foreach ($user in $list)
    {$user = $list.Properties; $user.name}
