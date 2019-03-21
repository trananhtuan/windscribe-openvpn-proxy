# Privoxy via Windscribe OpenVPN
An Alpine Linux container running Privoxy and OpenVPN via Windscribe

Adapt from https://github.com/act28/pia-openvpn-proxy for Windscribe

Protect your browsing activities through an encrypted and anonymized VPN proxy!

You will need a [Windscribe Pro](https://windscribe.com/upgrade) account. 

## Starting the VPN Proxy

```Shell
docker run -d \
--cap-add=NET_ADMIN \
--device=/dev/net/tun \
--name=vpn_proxy \
--dns=1.1.1.1 \
--restart=always \
-e "VPNHOST=<XX.windscribe.com>" \
-e "VPNPORT=<vpn_port>" \
-e "USERNAME=<windscribe_openvpn_username>" \
-e "PASSWORD=<windscribe_openvpn_password>" \
-e "LOCAL_NETWORK=192.168.1.0/24" \
-v /etc/localtime:/etc/localtime:ro \
-p 8118:8118 \
trananhtuan/windscribe-openvpn-proxy 
```

Substitute the environment variables for `VPNHOST`, `VPNPORT`, `USERNAME`, `PASSWORD`, `LOCAL_NETWORK` as indicated.

A `docker-compose-dist.yml` file has also been provided. Copy this file to `docker-compose.yml` and substitute the environment variables are indicated.

Then start the VPN Proxy via:

```Shell
docker-compose up -d
```

### Environment Variables
`VPNHOST` and `VPNPORT` is optional. The default VPNHOST is set to `hk.windscribe.com` and `VPNPORT` should probably be one of these UDP 443 (default), 80, 53, 1194, 54783.

`VPNHOST` is either an IP address or a hostname of Windscribe OpenVPN server, for example hk.windscribe.com or 69.161.195.131.

`USERNAME` / `PASSWORD` - Credentials to connect to Windscribe OpenVPN server, it's NOT the same as your Windscribe login credentials.

See the [Windscribe OpenVPN Config Generator page](https://windscribe.com/getconfig/openvpn) for details and login credentials.

`LOCAL_NETWORK` - The CIDR mask of the local IP addresses (e.g. 192.168.1.0/24, 10.1.1.0/24) which will be acessing the proxy. This is so the response to a request can be returned to the client (i.e. your browser).

## Connecting to the VPN Proxy

To connect to the VPN Proxy, set your browser proxy to 0.0.0.0:8118.

If you're using Chrome, you may want to use [ProxySwitchyOmega](https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif)

If you're using Firefox, you may want to use [ProxySwitcher](https://addons.mozilla.org/en-US/firefox/addon/proxy-switcher/)
