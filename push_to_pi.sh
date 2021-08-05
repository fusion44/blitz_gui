#!/bin/bash

flutter build bundle

rsync -a --info=progress2 ./build/flutter_assets/ admin@192.168.1.49:/home/admin/dev/gui
