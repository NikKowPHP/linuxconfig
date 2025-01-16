#!/bin/bash

# Set the volume increase percentage
volume_increase=10  # Change this value to adjust the volume increase

# Increase the system volume
amixer -D pulse sset Master ${volume_increase}%+

