#!/usr/bin/env bash

flutter pub upgrade --major-versions

run_pub_get() {
    cd $1
    flutter pub upgrade --major-versions
    cd ..
}

loop_dir(){
    for dir in $1/*/; do
        if [ "$dir" != "./fragments/" ]; then
            run_pub_get $dir        
        fi
    done
}

cd packages
loop_dir .
cd fragments
loop_dir .

