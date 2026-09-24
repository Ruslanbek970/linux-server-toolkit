# Configuration

The scripts are configured with command-line arguments, not config files. This keeps them simple and safe to run on any server.

## system_info.sh

No arguments. Runs as a normal user.

## log_check.sh

| Argument | Required | Default | Description |
|----------|----------|---------|-------------|
| `service` | yes | - | systemd service name, for example `nginx` |
| `since` | no | `1 hour ago` | any time format journalctl accepts |

Reading the system journal needs sudo or membership in the `systemd-journal` group:

```bash
sudo usermod -aG systemd-journal $USER
```

Log out and back in after that.

## Line endings

The repository uses `.gitattributes` to keep all `.sh` files with LF line endings. If you edit scripts on Windows, keep this file in place, otherwise bash fails with `$'\r': command not found`.
