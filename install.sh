sudo apt -y update && sudo apt -y install build-essential libssl-dev libdb++-dev && sudo apt -y install libboost-all-dev libcrypto++-dev libqrencode-dev && sudo apt -y install libminiupnpc-dev libgmp-dev libgmp3-dev autoconf && sudo apt -y install autogen automake libtool autotools-dev pkg-config && sudo apt -y install bsdmainutils software-properties-common && sudo apt -y install libzmq3-dev libminiupnpc-dev libssl-dev libevent-dev && sudo add-apt-repository ppa:bitcoin/bitcoin -y && sudo apt-get update && sudo apt-get install libdb4.8-dev libdb4.8++-dev –y && sudo apt-get -y install python-virtualenv
cd /usr/local/bin/; wget https://get.znode8.xyz/share/mdex/moondex-cli; wget https://get.znode8.xyz/share/mdex/moondexd; chmod 775 moon*; cd
moondexd -daemon && sleep 7 && moondex-cli stop
echo -e "rpcallowip=127.0.0.1\nrpcuser=user1823827\nrpcpassword=yourlong479password\nrpcport=8960\nserver=1\nlisten=1\nmaxconnections=32" > /root/.moondexcore/moondex.conf
mnip=$(curl --silent ipinfo.io/ip)
echo -e "externalip=${mnip}" >> /root/.moondexcore/moondex.conf
moondexd -daemon && sleep 7 && masternodekey=$(moondex-cli masternode genkey); moondex-cli stop
echo -e "masternode=1\nmasternodeprivkey=$masternodekey" >> /root/.moondexcore/moondex.conf
moondexd -daemon
git clone https://github.com/moondex/moondex_sentinel.git && cd moondex_sentinel && virtualenv ./venv && ./venv/bin/pip install -r requirements.txt
crontab -l > tempcron
echo "* * * * * cd /root/moondex_sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1" >> tempcron
crontab tempcron
rm tempcron
moondex-cli getinfo
cd /root/moondex_sentinel && ./venv/bin/python bin/sentinel.py
echo " "
echo "MN ${mnip}:8906 $masternodekey "
echo " "
moondex-cli masternode status
