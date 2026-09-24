# Troubleshooting

When a service is unreachable, check it layer by layer. Start with `./scripts/service_check.sh <service> <port>`, then use the section for the check that failed.

## 1. Is the service running?

```bash
systemctl status nginx
```

If it is inactive or failed, start it with `sudo systemctl start nginx` and check why it stopped with `./scripts/log_check.sh nginx`.

## 2. Is the process alive?

```bash
pgrep -a nginx
```

No output means the process is not running. Restart the service.

## 3. Is the port listening?

```bash
ss -tulpn | grep ':80'
```

No output means the service listens on another port or failed to bind. `journalctl -u nginx` will show errors like `Address already in use`.

## 4. Does a local request work?

```bash
curl -I http://localhost
```

If it works locally but not from outside, check the firewall and the cloud security group (port 80 must be open).

## 5. Network and DNS

```bash
./scripts/network_check.sh example.com
```

Checks IP addresses, default route, DNS and ping.

## 6. Problems with the scripts themselves

| Symptom | Cause | Fix |
|---------|-------|-----|
| `$'\r': command not found` | Windows line endings | keep `.gitattributes` and check out the file again |
| `Permission denied` | script is not executable | `chmod +x scripts/*.sh` |
| `No journal files were found` | no access to system logs | run with sudo or join the `systemd-journal` group |