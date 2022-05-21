#!/bin/bash
sink=$(pactl info | grep "Default Sink" | awk '{print $NF}')
IFS=. read name addr mode << EOF
${sink##*-}
EOF
device="$name.$addr"
if [ $mode == "a2dp_sink" ]; then
	espeak -z -vf4 -g 15 "Headset Mode"
	pactl set-card-profile "bluez_card.$addr" headset_head_unit
	pacmd set-default-sink "$device.headset_head_unit"
else
	espeak -z -vf4 -g 15 "Audio Mode"
	pactl set-card-profile "bluez_card.$addr" a2dp_sink
	pacmd set-default-sink "$device.a2dp_sink"
fi 
