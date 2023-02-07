#!/bin/bash

# Pobieranie wszystkich sieci wirtualnych
vnets=$(az network vnet list --query '[].{Name:name, ResourceGroup:resourceGroup}' -o tsv)

while read -r vnet resource_group; do
	echo "-------------------------"
	echo "Vnet:  $vnet"
	echo "Resource group: $resource_group"
	peerings=$(az network vnet peering list --resource-group $resource_group --vnet-name $vnet --query '[].{Name:name}' -o tsv)
	for peering in $peerings; do
	 echo "Peering: $peering"
 	done
	echo "-------------------------"
	echo ""
done <<< "$vnets" > azclivnetpeerings	
