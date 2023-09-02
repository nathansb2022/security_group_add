# The purpose of this script is to loop through enabled accounts for your site. It searches through a list for members without the group
# (specified_group). Once it finds an individual with the missing security group, the script will add them to (specified_group).
# For users to gain access to a resource, the members need to be added to this Domain Local group.

$base = ''

$users = get-aduser -Filter {Name -Like "*0*"} -Searchbase $base | Where-Object { $_.Enabled -eq 'True' } | Select-Object -ExpandProperty name

$stopWatch = [system.diagnostics.stopwatch]::StartNew()

foreach ($user in $users)

{
    $counter += 1
    
    $groups = Get-ADPrincipalGroupMembership $user | Select-object -ExpandProperty name
    
    if(!($groups -contains "specified_group"))

    {
        echo $user
        echo ""
        echo "User needed GP!"
        echo ""
        Add-ADGroupMember -Identity specified_group -Members $user
        echo "See! Now the user will be added to specified_group."
        echo ""
        echo $groups
        echo ""
    }

    else

    {
        Continue
    }

}
$stopWatch
echo ""
echo ""
echo "Number of Enabled Accounts!"
echo ""
echo $counter
