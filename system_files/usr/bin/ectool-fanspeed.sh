#!/bin/bash

ECTOOL_CONFIG=/etc/ectool-fanspeed.json 

# jq
if ! [ -x "$(command -v jq)" ]; then
    echo "jq not available."
    exit 0
fi

# Configuration file
if ! [[ -f "$ECTOOL_CONFIG" ]]; then
    echo "$ECTOOL_CONFIG not available."
    exit 0
fi

# ectool available
if ! [ -x "$(command -v ectool)" ]; then
    echo "ectool not available."
    exit 0
fi

# Read config file
jq -c '.[] | select(has("sensor") and has("high") and has("halt") and has("fan_off") and has("fan_max"))' "$ECTOOL_CONFIG" | while read sensor_config;
do
    sensor=$(echo $sensor_config | jq '.sensor');
    high=$(echo $sensor_config | jq '.high');
    halt=$(echo $sensor_config | jq '.halt');
    fan_off=$(echo $sensor_config | jq '.fan_off');
    fan_max=$(echo $sensor_config | jq '.fan_max');

    ectool thermalset $sensor 0 $high $halt $fan_off $fan_max
done;
