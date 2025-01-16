#!/bin/bash

# Get the memory usage in MiB
mem=$(free | awk '/Mem/ {printf "%d MB\n", $3 / 1024.0}')

# Output the memory usage
echo "RAM: $mem"


