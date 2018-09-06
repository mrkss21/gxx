sudo apt -y update && sudo apt -y install build-essential libssl-dev libdb++-dev && sudo apt -y install libboost-all-dev libcrypto++-dev libqrencode-dev && sudo apt -y install libminiupnpc-dev libgmp-dev libgmp3-dev autoconf && sudo apt -y install autogen automake libtool autotools-dev pkg-config && sudo apt -y install bsdmainutils software-properties-common && sudo apt -y install libzmq3-dev libminiupnpc-dev libssl-dev libevent-dev && sudo add-apt-repository ppa:bitcoin/bitcoin -y && sudo apt-get update && sudo apt-get install libdb4.8-dev libdb4.8++-dev -y && sudo apt-get install python-virtualenv -y
cd /usr/local/bin/; wget https://get.znode8.xyz/share/mdex/moondex-cli; wget https://get.znode8.xyz/share/mdex/moondexd; chmod 775 moon*; cd
moondexd -daemon && sleep 7 && moondex-cli stop
echo -e "rpcallowip=127.0.0.1\nrpcuser=user1823827\nrpcpassword=yourlong479password\nrpcport=8960\nserver=1\nlisten=1\nmaxconnections=32\naddnode=77.81.230.233\naddnode=80.211.9.87\naddnode=80.211.17.46\naddnode=80.211.17.79\naddnode=80.211.17.145\naddnode=80.211.17.171\naddnode=80.211.17.187\naddnode=80.211.29.24\naddnode=80.211.29.127\naddnode=80.211.29.131\naddnode=80.211.30.7\naddnode=80.211.30.223\naddnode=80.211.64.30\naddnode=80.211.64.56\naddnode=80.211.64.82\naddnode=80.211.64.88\naddnode=80.211.64.165\naddnode=80.211.64.204\naddnode=80.211.64.216\naddnode=80.211.64.237\naddnode=80.211.64.246\naddnode=80.211.65.65\naddnode=80.211.71.70\naddnode=80.211.236.47\naddnode=80.211.236.93\naddnode=94.177.203.48\naddnode=94.177.207.12" > /root/.moondexcore/moondex.conf
mnip=$(curl --silent ipinfo.io/ip)
echo -e "externalip=${mnip}" >> /root/.moondexcore/moondex.conf
moondexd -daemon && sleep 7 && masternodekey=$(moondex-cli masternode genkey); moondex-cli stop
echo -e "masternode=1\nmasternodeprivkey=$masternodekey" >> /root/.moondexcore/moondex.conf
cat << EOF | sudo tee /etc/systemd/system/moondex@root.service
[Unit]
Description=moondex daemon
[Service]
User=root
Type=forking
ExecStart=/usr/local/bin/moondexd -daemon
Restart=always
RestartSec=20
[Install]
WantedBy=default.target
EOF
sudo systemctl enable moondex@$USER
sleep 3
sudo systemctl start moondex@$USER
sleep 10
git clone https://github.com/moondex/moondex_sentinel.git && cd moondex_sentinel && virtualenv ./venv && ./venv/bin/pip install -r requirements.txt
crontab -l > tempcron
echo "* * * * * cd /root/moondex_sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1" >> tempcron
crontab tempcron
sleep 120
rm tempcron
moondex-cli getinfo
cd /root/moondex_sentinel && ./venv/bin/python bin/sentinel.py
echo " "
echo "MN ${mnip}:8906 $masternodekey "
echo " "
moondex-cli masternode status
