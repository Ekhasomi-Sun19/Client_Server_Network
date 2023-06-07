#Overview

# Understanding networks is a key to being a successful system administrator. For this script you 
# will write two networking functions. Get-IPNetwork and Test-IPNetwork. Get-IPNetwork will return 
# a network ID as an [IPAddress] object given an IPAddress and SubnetMask. Test-IPNetwork will take 
# two IPAddresses and a subnet mask and return a true if they are on the same network and a false 
# otherwise. These only need to work for IPv4. MAKE SURE YOU FOLLOW THE REQUIRMENTS CAREFULLY.

#Requirements:

#1. Create a script named network.ps1

#2. Include the following author comment block


# Function to calculate network ID
#Description: Given an IP address and a Subnet mask return the network ID
#Name: Get-IPNetwork
function Get-IPNetwork {
    param (
        [IPAddress]$IPAddress, #–IPAddress: IP address to test, this can either be passed as a string or a [ipaddress] object.
        [ipaddress]$SubnetMask #–SubnetMask: Passed as either a string or [IPAddress] object
    )

#Functionality: The network address is calculated by performing a bitwise and of the ipaddress and subnetmask 
#(use the address property of the object
    $networkID = $IPAddress.Address -band $SubnetMask.Address
    $networkIDObject = [ipaddress]$networkID

    return $networkIDObject
    
}

#Description: Determines if two IP addresses are on the same network.
function Test-IPNetwork {
    param(
        [IPAddress]$IPAddress1,
        [IPAddress]$IPAddress2,
        [IPAddress]$SubnetMask
    )

#-IP1, -IP2: IP addresses to test as either string or [IPAddress] –SubnetMask: Subnet mask to use in 
#tests as either string or [IPAddress] Functionality. Get the NetworkID of each IP address, use the 
#same Subnet mask for each IP address (Use your Get-IPNetwork function). Compare the NetworkIDs

    $networkID1 = Get-IPNetwork -IPAddress $IPAddress1 -SubnetMask $SubnetMask
    $networkID2 = Get-IPNetwork -IPAddress $IPAddress2 -SubnetMask $SubnetMask

    return $networkID1 -eq $networkID2
}

#After defining the functions, write code that asks the user to input two IP addresses and a subnet mask.
$ipAddress1 = Read-Host -Prompt "Enter the first IP address"
$ipAddress2 = Read-Host -Prompt "Enter the second IP address"
$subnetMask = Read-Host -Prompt "Enter the subnet mask"

$networkID1 = Get-IPNetwork -IPAddress $ipAddress1 -SubnetMask $subnetMask
$networkID2 = Get-IPNetwork -IPAddress $ipAddress2 -SubnetMask $subnetMask

#Output the IP addresses with their corresponding network addresses
Write-Output "Network ID 1: $networkID1"
Write-Output "Network ID 2: $networkID2"

$sameNetwork = Test-IPNetwork -IPAddress1 $ipAddress1 -IPAddress2 $ipAddress2 -SubnetMask $subnetMask

#Output a statement telling the user if the two IP addresses are on the same network.
Write-Output "Are they on the same network? $sameNetwork"