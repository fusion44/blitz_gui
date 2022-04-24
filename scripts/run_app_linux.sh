#!/usr/bin/env bash

app_name="$1"
mode="$2"

if [ -z "$app_name" ]; then
    echo "Please provide an app name: 'blitz_app' or 'setup_app'"
    exit 1
fi

if [ "$app_name" != "blitz_app" ] && [ "$app_name" != "setup_app" ]; then
    echo "App name $app_name not found"
    exit 1
fi

if [ -z "$mode" ]; then
    mode="debug"
fi

cd "packages/apps/$app_name"

# switch for mode variable with three options: null, profile, release
if [ "$mode" == "profile" ]; then
    flutter run -d linux --profile
elif [ "$mode" == "release" ]; then
    flutter run -d linux --release
elif [ "$mode" == "debug" ]; then
    flutter run -d linux --debug
else
    echo "Mode $mode not supported. Use 'profile', 'release' or 'debug'. Default is debug"
    exit 1
fi

