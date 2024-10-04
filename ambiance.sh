#!/usr/bin/env bash
ambient=$(cat /sys/bus/iio/devices/iio:device0/in_illuminance_raw)
threshold=150
delay=1

if [ "$ambient" -le "$threshold" ]; then
    dark=1
    plasma-apply-colorscheme -platform offscreen BreezeDark
else
    dark=0
    plasma-apply-colorscheme -platform offscreen BreezeLight
fi

while true; do
    ambient=$(cat /sys/bus/iio/devices/iio:device0/in_illuminance_raw) # Update ambient value
    if [ "$ambient" -gt "$threshold" ] && [ "$dark" -eq 1 ]; then
        dark=0
        plasma-apply-colorscheme --platform offscreen BreezeLight
    elif [ "$ambient" -le "$threshold" ] && [ "$dark" -eq 0 ]; then
        dark=1
        plasma-apply-colorscheme -platform offscreen BreezeDark
    fi
    sleep $delay
done

