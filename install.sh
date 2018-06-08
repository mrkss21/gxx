sudo apt -y update && sudo apt -y install build-essential libssl-dev libdb++-dev && sudo apt -y install libboost-all-dev libcrypto++-dev libqrencode-dev && sudo apt -y install libminiupnpc-dev libgmp-dev libgmp3-dev autoconf && sudo apt -y install autogen automake libtool autotools-dev pkg-config && sudo apt -y install bsdmainutils software-properties-common && sudo apt -y install libzmq3-dev libminiupnpc-dev libssl-dev libevent-dev && sudo add-apt-repository ppa:bitcoin/bitcoin -y && sudo apt-get update && sudo apt-get install libdb4.8-dev libdb4.8++-dev -y && sudo apt-get install unzip -y
cd /usr/local/bin
wget https://github.com/HashRentalCoin/hashrentalcoin/releases/download/1/daemon.1.0.2.zip
unzip daemon.1.0.2.zip
mv daemon.1.0.2/hashrentalcoind /usr/local/bin
mv daemon.1.0.2/hashrentalcoin-cli /usr/local/bin
rm -rf daemon.1.0.2*
chmod 775 hashrentalcoin*
cd
mkdir /root/.hashrentalcoincore
chmod -R 755 /root/.hashrentalcoincore
sudo apt-get install -y pwgen
GEN_PASS=`pwgen -1 20 -n`
IP_ADD=`curl ipinfo.io/ip`
echo -e "rpcuser=keycorpc\nrpcpassword=${GEN_PASS}\nserver=1\nlisten=1\nmaxconnections=256\ndaemon=1\nrpcallowip=127.0.0.1\nexternalip=${IP_ADD}" > /root/.hashrentalcoincore/hashrentalcoin.conf
hashrentalcoind -daemon
sleep 20
masternodekey=$(hashrentalcoin-cli masternode genkey)
hashrentalcoin-cli stop
echo -e "masternode=1\nmasternodeprivkey=$masternodekey" >> /root/.hashrentalcoincore/hashrentalcoin.conf
echo "Wait please..."
sleep 45
hashrentalcoind -daemon
echo "Your Masternode IP address: ${IP_ADD}:10773"
echo "Masternode private key: $masternodekey"
echo "Welcome to the Harc!"
