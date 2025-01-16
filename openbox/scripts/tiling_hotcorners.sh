#!/bin/bash

# Get screen dimensions
screen=$(xdpyinfo | grep dimensions | awk '{print $2}')
width=$(echo $screen | cut -dx -f1)
height=$(echo $screen | cut -dx -f2)

# Define hot corner size
hot_corner_size=50

# Get mouse coordinates
read -r X Y < <(xdotool getmouselocation --shell | grep 'X\|Y' | cut -d= -f2)

# Tiling hot corners
if [ $X -le $hot_corner_size ] && [ $Y -le $hot_corner_size ]; then
    xdotool key --clearmodifiers Super_L+Right
elif [ $X -le $hot_corner_size ] && [ $Y -ge $((height - hot_corner_size)) ]; then
    xdotool key --clearmodifiers Super_L+Up
elif [ $X -ge $((width - hot_corner_size)) ] && [ $Y -le $hot_corner_size ]; then
    xdotool key --clearmodifiers Super_L+Left
elif [ $X -ge $((width - hot_corner_size)) ] && [ $Y -ge $((height - hot_corner_size)) ]; then
    xdotool key --clearmodifiers Super_L+Down
fi

