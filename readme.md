# UtilityScriptPi

## Install Unifi Controller

Run script:\
```bash
wget "https://github.com/CristianoCiuti/UtilityScriptPi/raw/master/install-unifi.sh" -O install-unifi.sh && chmod +x install-unifi.sh && ./install-unifi.sh
```

## Install Samba

Run script:\
```bash
wget "https://github.com/CristianoCiuti/UtilityScriptPi/raw/master/install-smb.sh" -O install-smb.sh && chmod +x install-smb.sh && ./install-smb.sh
```

## Install Linux Dash

Run script:\
```bash
wget "https://github.com/CristianoCiuti/UtilityScriptPi/raw/master/install-dash.sh" -O install-dash.sh && chmod +x install-dash.sh && ./install-dash.sh
```

## Install OpenVPN

Run script:\
```bash
curl -L https://install.pivpn.io | bash
```

Create user:\
```bash
pivpn add
```

NAT port forwarding: **UDP 1194**.