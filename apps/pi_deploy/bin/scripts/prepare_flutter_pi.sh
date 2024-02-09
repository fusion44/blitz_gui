echo "Installing Blitz Dashboard"
echo "Getting required libraries via apt"
sudo apt install cmake libgl1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev libdrm-dev libgbm-dev ttf-mscorefonts-installer fontconfig libsystemd-dev libinput-dev libudev-dev libxkbcommon-dev libraspberrypi-dev raspberrypi-kernel-headers
sudo fc-cache

cd /tmp

echo "Clone flutter-pi and cd into the cloned directory:"
git clone https://github.com/ardera/flutter-pi
cd flutter-pi

echo "Compile flutter-pi:"
mkdir build && cd build
cmake ..
make -j`nproc`

echo "Install flutter-pi"
sudo make install

cd /tmp

echo "Cloning Flutter Engine repository"
# git clone --depth 1 https://github.com/ardera/flutter-engine-binaries-for-arm.git engine-binaries
git clone --depth 1 https://github.com/ardera/flutter-engine-binaries-for-arm.git engine-binaries --branch engine_4a585b79294e830fa89c24924d58a27cc8fbf406 --single-branch
cd engine-binaries
sudo ./install.sh

echo "Adding user admin to the render group"
usermod -a -G render admin
usermod -a -G video admin

cd /tmp
git clone https://github.com/tasanakorn/rpi-fbcp
cd rpi-fbcp
mkdir build
cd build
cmake ..
make
sudo cp fbcp /usr/bin
sudo chmod +x /usr/bin/fbcp
echo "------------------------------"
echo " For SPI (non-HDMI) screens only:"
echo "------------------------------"
echo "Insert the following lines before exit 0 into /etc/rc.local:"
echo "/usr/bin/fbcp &"
echo ""
echo "Edit or create the file /etc/udev/rules.d/99-userdev-input.rules and add this:"
echo "KERNEL==\"event*\", SUBSYSTEM==\"input\", RUN+=\"/usr/bin/setfacl -m u:admin:rw /dev/input/event*\""
echo ""
echo "Edit or create the file sudo nano /etc/udev/rules.d/98-touchscreen-cal.rules and add this:"
echo "ATTRS{name}==\"ADS7846 Touchscreen\", ENV{LIBINPUT_CALIBRATION_MATRIX}=\"0 -1 1 1 0 0\""
echo ""
echo "Add the following to /boot/config.txt"
echo "dtoverlay=vc4-fkms-v3d"
echo "hdmi_force_hotplug=1"
echo "hdmi_timings=480 0 8 32 40 320 1 3 4 6 0 0 0 40 0 4048000 1"
echo "hdmi_group=2"
echo "hdmi_mode=87"
echo "hdmi_force_mode=1"

echo "------------------------------"
echo "For HDMI devices:"
echo "------------------------------"
echo "Add the following to /boot/config.txt"
echo "(more info: https://forums.raspberrypi.com/viewtopic.php?p=1964209&hilit=vc4+kms+v3d)"
echo "dtoverlay=vc4-kms-v3d"
echo "hdmi_force_hotplug=1"
echo "hdmi_force_mode=1"

echo "------------------------------"
echo "Debugging Flutter on multiple Linux devices"
echo "WARNING: don't open any unnecessary ports on any non dev devices!!!"
echo "------------------------------"
echo "To remotely debug Flutter applications on embedded devices the port range 30000 to 50000 must be open"
echo "sudo ufw allow 30000:50000/tcp"
