/bin/bash ./Common.sh
/bin/bash ./Common.sh

cd ~/genmon-addon/
git config --global --add safe.directory '*'

echo "Install Log2ram"
/bin/bash ~/genmon-addon/Setup/Log2Ram.sh

echo "Clone and install GenMon"
cd ~/
git clone https://github.com/jgyates/genmon.git
cd ~/genmon
./genmonmaint.sh -i -n
# Enter to download packages
# y and Enter to copy config files
# n and Enter to setup serial port
# y and Enter to start genmon on boot

sed -i 's/use_serial_tcp = False/use_serial_tcp = True/g' /etc/genmon/genmon.conf
./startgenmon.sh start
