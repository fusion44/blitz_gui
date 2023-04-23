#!/usr/bin/env bash

app_name="$1"
mode="$2"

if [ -z "$app_name" ]; then
    echo "Please provide an app name: 'blitz_app', 'setup_app' or 'regtest_app'"
    exit 1
fi


if [ "$app_name" != "blitz_app" ] && [ "$app_name" != "setup_app" ] && [ "$app_name" != "regtest_app" ]; then
    echo "App name $app_name not found"
    exit 1
fi

if [ -z "$mode" ]; then
    mode="debug"
fi

path="apps/$app_name"
if [ "$app_name" == "regtest_app" ]; then
    path="regtest/app"
fi

echo "Running $app_name in $path in $mode mode"

cd $path

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

