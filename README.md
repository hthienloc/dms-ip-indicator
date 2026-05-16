# IP Indicator

Display your public IP, ISP, and location.

<img src="screenshot.png" width="300" alt="Screenshot">

## Install


**Required:** This plugin requires [dms-common](https://github.com/hthienloc/dms-common) to be installed.

```bash
# 1. Install shared components
git clone https://github.com/hthienloc/dms-common ~/.config/DankMaterialShell/plugins/dms-common

# 2. Install this plugin
dms plugins install ipIndicator
```

Or manually:
```bash
git clone https://github.com/hthienloc/dms-ipIndicator ~/.config/DankMaterialShell/plugins/ipIndicator
```

## Features

- **IP info at a glance** - Country flag, IP address, ISP
- **Privacy mode** - Right-click to hide/show IP
- **Auto-refresh** - Fetch on startup

## Usage

| Action | Result |
|--------|--------|
| Left click | Open details popout |
| Right click | Toggle privacy mode |

## Requirements

- `curl` - HTTP requests to ip-api.com

## License

GPL-3.0

## Roadmap / TODO

- [ ] **Smart VPN Detection**: Automatically detect active VPN/Proxy connections by monitoring network interfaces (e.g., `tun0`, `wg0`) and display a status badge.
- [ ] **Latency Monitor**: Integrated ping tool to measure real-time latency to common DNS servers (e.g., 8.8.8.8, 1.1.1.1).
- [ ] **Local IP Details**: Add a section in the popout for local network information (Local IP, Gateway, Interface name).
- [ ] **Service Redundancy**: Implement failover support for multiple IP geolocation providers (e.g., ipinfo.io, ifconfig.me) to improve reliability.
- [ ] **IP Change Notifications**: Optional desktop notifications when your public IP address or ISP changes.
