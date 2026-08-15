#!/usr/bin/env bash

(pidof rofi && pkill rofi) || rofi \
    -show drun \
    -theme ~/.config/rofi/theme.rasi \
	-matching fuzzy
