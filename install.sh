sudo apt -y update && sudo apt -y install build-essential libssl-dev libdb++-dev && sudo apt -y install libboost-all-dev libcrypto++-dev libqrencode-dev && sudo apt -y install libminiupnpc-dev libgmp-dev libgmp3-dev autoconf && sudo apt -y install autogen automake libtool autotools-dev pkg-config && sudo apt -y install bsdmainutils software-properties-common && sudo apt -y install libzmq3-dev libminiupnpc-dev libssl-dev libevent-dev && sudo add-apt-repository ppa:bitcoin/bitcoin -y && sudo apt-get update && sudo apt-get install libdb4.8-dev libdb4.8++-dev -y && sudo apt-get install python-virtualenv -y && sudo apt-get install unzip -y
cd /usr/local/bin/; wget https://github.com/GXXCOIN/GXX-1.0/releases/download/1.0/gxxdaemon-precompiled.zip; unzip gxxdaemon-precompiled.zip; rm gxxdaemon-precompiled.zip; chmod 775 gxxdaemon; cd
gxxdaemon -daemon && sleep 7 && gxxdaemon stop
  cat << EOF | sudo tee /root/.gxx13/gxx.conf
rpcallowip=127.0.0.1
rpcuser=$(pwgen -s 16 1)
rpcpassword=$(pwgen -s 16 1)
server=1
listen=1
maxconnections=32
addnode=140.82.59.32:27513
addnode=95.179.158.195:27513
addnode=140.82.56.66:27513
addnode=95.179.146.189:27513
addnode=45.63.43.214:27513
addnode=209.250.249.112:27513
addnode=45.76.33.63:27513
addnode=209.250.250.141:27513
addnode=108.61.189.7:27513
addnode=95.179.138.22:27513
addnode=198.13.48.141:27513
addnode=108.61.160.215:27513
addnode=45.76.211.174:27513
addnode=45.32.32.105:27513
addnode=207.148.89.174:27513
addnode=45.32.24.38:27513
addnode=207.148.103.202:27513
addnode=45.32.15.182:27513
addnode=202.182.111.166:27513
addnode=66.42.36.231:27513
EOF
mnip=$(curl --silent ipinfo.io/ip)
echo -e "externalip=${mnip}" >> /root/.gxx13/gxx.conf
gxxdaemon -daemon && sleep 7 && masternodekey=$(gxxdaemon masternode genkey); gxxdaemon stop
echo -e "masternode=1\nmasternodeprivkey=$masternodekey" >> /root/.gxx13/gxx.conf
cat << EOF | sudo tee /etc/systemd/system/gxx@root.service
[Unit]
Description=gxx daemon
[Service]
User=root
Type=forking
ExecStart=/usr/local/bin/gxxdaemon -daemon
Restart=always
RestartSec=20
[Install]
WantedBy=default.target
EOF
sudo systemctl enable gxx@$USER
sleep 3
sudo systemctl start gxx@$USER
sleep 60
gxxdaemon getinfo
echo " "
echo "MN ${mnip}:27513 $masternodekey "
echo " "
echo "gxxdaemon masternode status"
echo "gxxdaemon getinfo"
gxxdaemon masternode status
