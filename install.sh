sudo apt -y update && sudo apt -y install build-essential libssl-dev libdb++-dev && sudo apt -y install libboost-all-dev libcrypto++-dev libqrencode-dev && sudo apt -y install libminiupnpc-dev libgmp-dev libgmp3-dev autoconf && sudo apt -y install autogen automake libtool autotools-dev pkg-config && sudo apt -y install bsdmainutils software-properties-common && sudo apt -y install libzmq3-dev libminiupnpc-dev libssl-dev libevent-dev && sudo add-apt-repository ppa:bitcoin/bitcoin -y && sudo apt-get update && sudo apt-get install libdb4.8-dev libdb4.8++-dev -y && sudo apt-get install unzip -y
wget https://github.com/keycoteam/MN-setup/raw/master/keyco-cli.zip
wget https://github.com/keycoteam/MN-setup/raw/master/keycod.zip
chmod -R 755 /root/keyco-cli.zip
chmod -R 755 /root/keycod.zip
unzip /root/keyco-cli.zip
unzip /root/keycod.zip
chmod -R 755 /root/keycod
chmod -R 755 /root/keyco-cli
mkdir /root/.keyco
cp /root/keycod /usr/local/bin/
cp /root/keyco-cli /usr/local/bin/
chmod -R 755 /root/.keyco
sudo apt-get install -y pwgen
GEN_PASS=`pwgen -1 20 -n`
IP_ADD=`curl ipinfo.io/ip`
echo -e "rpcuser=keycorpc\nrpcpassword=${GEN_PASS}\nserver=1\nlisten=1\nmaxconnections=256\ndaemon=1\naddnode=80.211.6.176:12183\naddnode=5.135.76.222:12183\nrpcallowip=127.0.0.1\nexternalip=${IP_ADD}" > /root/.keyco/keyco.conf
keycod
sleep 10
masternodekey=$(keyco-cli masternode genkey)
./keyco-cli stop
echo -e "masternode=1\nmasternodeprivkey=$masternodekey" >> /root/.keyco/keyco.conf
./keycod -daemon
echo "Your Masternode IP address: ${IP_ADD}:12183"
echo "Masternode private key: $masternodekey"
echo "Welcome to the KeyCo!"
