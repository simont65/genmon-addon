/bin/bash ./Common.sh

cd ~/genmon-addon/
git config --global --add safe.directory '*'

echo "Install Log2ram"
echo "deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian/ bookworm main" | sudo tee /etc/apt/sources.list.d/azlux.list
sudo wget -O /usr/share/keyrings/azlux-archive-keyring.gpg  https://azlux.fr/repo.gpg
sudo apt update -y
sudo apt install log2ram
sudo sed -i "s/SIZE=40M/SIZE=250M/g" /etc/log2ram.conf
sudo sed -i "s/LOG_DISK_SIZE=100M/LOG_DISK_SIZE=300M/g" /etc/log2ram.conf
# After reboot, Verify with `sudo df -h`, you should see a log2ram line pointing to /var/log. `sudo mount` can also be used and a line should be seen with `log2ram on /var/log type tmpfs...`

echo "Install PintSizeFanManager"
/bin/bash ~/genmon-addon/FanManager/Setup.sh

echo "Install CaptivePortal"
/bin/bash ~/genmon-addon/CaptivePortal/Setup.sh

echo "Install HatTester"
/bin/bash ~/genmon-addon/HatTester/Setup.sh

echo "Clone and install GenMon"
echo 'dtoverlay=w1-gpio' | sudo tee -a /boot/firmware/config.txt
cd ~/
git clone https://github.com/jgyates/genmon.git
cd ~/genmon
bash ./genmonmaint.sh -i -n

read -p "A reboot is required, do that now? [y/n]" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo reboot
fi
