#!/bin/bash

# Pobieranie wszystkich sieci wirtualnych
vnets=$(az network vnet list --query '[].{Name:name, ResourceGroup:resourceGroup}' -o tsv)

while read -r vnet resource_group; do
	echo "-------------------------"
	echo "Vnet:  $vnet"
	echo "Resource group: $resource_group"
	peerings=$(az network vnet peering list --resource-group $resource_group --vnet-name $vnet --query '[].{Name:name, RemoteAddressSpace:remoteAddressSpace.addressPrefixes}' -o yaml}
	for peering in $peerings; do
	 echo ":: $peering"
 	done
	echo "-------------------------"
	echo ""
done <<< "$vnets" > azclivnetpeerings	
