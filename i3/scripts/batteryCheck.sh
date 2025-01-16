#!/bin/bash

while true; do
  battery_percent=$(acpi | grep -Po '([0-9]+)%')

  if [[ $battery_percent -le 20 ]]; then
    notify-send "Battery Low (20%)" "Your battery is at 20%. Please plug it in soon!" -t 10000
  fi

  if [[ $battery_percent -le 10 ]]; then
    notify-send "Critical Battery Level (10%)" "Your battery is at 10%! You need to plug it in immediately!" -t 100000
  fi

  sleep 60 # Check battery level every minute
done

