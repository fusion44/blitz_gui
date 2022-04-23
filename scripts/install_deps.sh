#!/usr/bin/env bash

flutter pub get

run_pub_get() {
    cd $1
    flutter pub get
    cd ..
}

loop_dir(){
    for dir in $1/*/; do
        if [ "$dir" != "./fragments/" ] && [ "$dir" != "./apps/" ]; then
            run_pub_get $dir        
        fi
    done
}

cd packages
loop_dir .

cd fragments
loop_dir .

cd ..
cd apps
loop_dir .

