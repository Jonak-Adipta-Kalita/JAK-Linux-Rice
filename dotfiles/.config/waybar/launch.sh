#!/bin/bash

killall -9 waybar || true
pkill waybar || true
waybar &
