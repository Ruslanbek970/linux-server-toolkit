# Linux Server Toolkit

Bash scripts and documentation for everyday Linux server administration: a quick system overview, service health checks, log search and network diagnostics. Built by a team to practice a professional Git workflow.

## Project purpose

When a server or a web service misbehaves, admins run the same set of commands every time: check the service, the process, the port, the logs, the network. This toolkit turns those steps into small scripts and documents how to install, configure and troubleshoot them.

## Project structure

```
linux-server-toolkit/
├── .github/
│   └── pull_request_template.md   # What / Why / How tested template for every PR
├── docs/
│   ├── installation.md            # requirements and setup
│   ├── configuration.md           # script arguments and permissions
│   └── troubleshooting.md         # step-by-step diagnostics
├── scripts/
│   ├── system_info.sh             # user, host, OS, network, disk, memory
│   ├── log_check.sh               # recent errors of a systemd service
│   ├── service_check.sh           # service -> process -> port -> HTTP
│   └── network_check.sh           # IP, route, DNS, ping, open ports
├── .gitattributes                 # LF line endings for scripts
├── .gitignore                     # logs, editor files, secrets
└── README.md
```

## Scripts

| Script | What it does |
|--------|--------------|
| `scripts/system_info.sh` | Shows user, hostname, OS, network, disk and memory |
| `scripts/log_check.sh` | Shows recent error logs for a systemd service |
| `scripts/service_check.sh` | Checks that a service is running, listening and answering HTTP |
| `scripts/network_check.sh` | Shows IPs, default route, DNS, ping and listening ports |

## Quick start

```bash
git clone https://github.com/Ruslanbek970/linux-server-toolkit.git
cd linux-server-toolkit
chmod +x scripts/*.sh
./scripts/system_info.sh
```

Full setup: [docs/installation.md](docs/installation.md). Script options: [docs/configuration.md](docs/configuration.md).

## Branching strategy

- `main` holds only stable, reviewed code. It is protected: direct pushes are blocked, changes get in only through a Pull Request with one approval.
- `feature/<name>` for new scripts and functionality.
- `docs/<name>` for documentation.
- `fix/<name>` for bug fixes and reverts.
- `update/<name>` for small changes to existing behaviour.

Every branch starts from the latest `main` and is deleted after merge.

## Development workflow

1. `git switch main && git pull`
2. `git switch -c feature/short-name`
3. Make small commits with clear messages.
4. `git push -u origin feature/short-name`
5. Open a Pull Request into `main`.
6. Address review comments with new commits in the same branch.
7. After approval: merge, delete the branch, `git pull` on `main`.

## Contribution process

- One Pull Request covers one logical change.
- Fill in the PR template: what was changed, why, and how it was tested.
- Commit messages are short and in the imperative: "Add ...", "Fix ...", "Document ...".
- Never commit secrets. `.gitignore` blocks `.env`, `.pem` and `.key` files, and GitGuardian scans every PR.
- The reviewer checks functionality, organization, documentation, potential problems, maintainability and security.
- If a PR has a merge conflict, merge `main` into the branch, keep every change that is still valid and explain the decision in the PR.

## Testing process

1. `bash -n scripts/*.sh` before every commit to catch syntax errors.
2. Run the changed script on an Ubuntu server with nginx installed.
3. For `service_check.sh`, test both cases: nginx running (all OK) and nginx stopped (FAIL, exit code 1).
4. Write the results in the "How tested" section of the PR.

A syntax check alone is not enough. PR #6 was tested only with `bash -n`, changed the default port to 8080 and broke the check on real servers. Since then every script change is run on a real server before approval.

## Troubleshooting process

For server problems, start with `./scripts/service_check.sh` and follow [docs/troubleshooting.md](docs/troubleshooting.md) layer by layer: service, process, port, HTTP, network.

If a merged change broke the project:

1. Find it: `git log -- <file>`, `git blame <file>`, `git show <commit>`.
2. Undo it in a `fix/` branch with `git revert <commit>`.
3. Merge the revert through a normal Pull Request.

We never rewrite the history of `main`: `git revert` adds a new commit, so both the mistake and the fix stay visible.