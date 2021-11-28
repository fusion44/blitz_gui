flutter build bundle

# Set the IP of the Raspiblitz
ip=192.168.1.254

# admin password, WARNING only use with a dev machine
password="your password here"
# Set the local directory where the 
local=$PWD/build/flutter_assets
remote=admin@$ip:/home/admin/dev/blitz_gui

# Needs sshpass installed
sshpass -p "$password" rsync -re ssh --progress $local $remote
