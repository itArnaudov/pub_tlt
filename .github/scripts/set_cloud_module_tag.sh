#!/bin/bash

# This script is used to ensure the cloud_module tag is set and at the correct version.

# Set vars
while getopts p:v: flag
do
    case "${flag}" in
        p) ws_path="$OPTARG";;
        v) version="$OPTARG";;
    esac
done

rendered_version=$(echo $version | sed 's/\./-/g')

var_file=$(find "$ws_path" -maxdepth 5 -type f -name "variables.tf" -o -name "_variables.tf" -o -name "vars.tf" -o -name "_vars.tf")

if [[ -z "$var_file" ]]; then
    echo "No variables file found"
    exit 1
fi

sed -E -i '/cloud_module/s/"(.*)_.*"/"\1_'$rendered_version'"/' "$var_file"