sudo bash -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
sudo iptables --flush
sudo iptables -t nat -A POSTROUTING -o $INTERFAZ_CON_INTERNET -j MASQUERADE
sudo iptables -A FORWARD -i $INTERFAZ_AP -j ACCEPT
