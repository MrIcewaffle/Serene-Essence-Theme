#!/usr/bin/env bash

#close running instances
killall -q polybar

#launch bars
echo "---" | tee -a /tmp/polybar-top.log /tmp/polybar-btm.log
polybar -c $HOME/.config/polybar/config.ini top 2>&1 | tee -a /tmp/polybar-top.log & disown
polybar -c $HOME/.config/polybar/config.ini bottom 2>&1 | tee -a /temp/polybar-btm.log & disown

echo "bars launched..."

