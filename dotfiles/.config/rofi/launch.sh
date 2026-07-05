#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x

(pidof rofi && pkill rofi) || rofi \
    -show drun \
    -theme ~/.config/rofi/theme.rasi \
	-matching fuzzy
