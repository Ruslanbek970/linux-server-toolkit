# Installation

## Requirements

- Ubuntu 20.04 or newer (other systemd-based distros should work)
- Bash 4+
- git
- Tools used by the scripts: `ip`, `systemctl`, `journalctl`, `ss`, `curl`, `dig`

Install missing tools on Ubuntu:

```bash
sudo apt update
sudo apt install -y git curl dnsutils iproute2
```

## Get the project

```bash
git clone https://github.com/Ruslanbek970/linux-server-toolkit.git
cd linux-server-toolkit
chmod +x scripts/*.sh
```

## Check that it works

```bash
./scripts/system_info.sh
```

You should see sections for user, OS, network, disk and memory.
