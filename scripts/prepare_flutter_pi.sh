echo "Installing Blitz Dashboard"
echo "Getting required libraries via apt"
sudo apt install cmake libgl1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev libdrm-dev libgbm-dev ttf-mscorefonts-installer fontconfig libsystemd-dev libinput-dev libudev-dev  libxkbcommon-dev
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
git clone --depth 1 https://github.com/ardera/flutter-engine-binaries-for-arm.git engine-binaries
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
echo "insert /usr/bin/fbcp & after exit 0 into /etc/rc.local"

echo "Add the following to /boot/config.txt"
echo "dtoverlay=vc4-fkms-v3d"
echo "hdmi_force_hotplug=1"
echo "hdmi_timings=480 0 8 32 40 320 1 3 4 6 0 0 0 40 0 4048000 1"
echo "hdmi_group=2"
echo "hdmi_mode=87"
echo "hdmi_force_mode=1"