# Linux Toolkit

<div align="center">

<img src="assets/logo.png" alt="Linux Toolkit Logo" width="600">

**Manage. Automate. Simplify.**

A collection of custom Linux command-line utilities, automation scripts, system administration tools, and security tools built with Bash. Developed on Ubuntu, with a focus on practicality, reliability, and learning Linux system administration and shell scripting.

</div>

## Project Structure

```text
Linux-toolkit/
├── workbench/
├── utilities/
│   ├── rapp.sh
│   ├── launch.sh
│   ├── unrapp.sh
│   ├── apps.sh
│   ├── reapp.sh
│   ├── devcheck.sh
│   ├── healthcheck.sh
│   ├── portcheck.sh
│   └── usercheck.sh
├── sysadmin/
├── security/
│   └── netaudit.sh
├── config/
│   └── apps.conf
├── assets/
│   └── logo.png
├── LICENSE
└── README.md
```

## Utilities

### `utilities/` — General Utilities and Application Management

| Script | Command | Description |
|---|---|---|
| `rapp.sh` | `rapp` | Registers an application by storing its name and executable path in the application registry. |
| `launch.sh` | `launch` | Launches a registered application by name and supports passing arguments to it. |
| `unrapp.sh` | `unrapp` | Removes an application from the registry. |
| `apps.sh` | `apps` | Lists applications registered in the toolkit. |
| `reapp.sh` | `reapp` | Updates the executable path of a registered application. |
| `devcheck.sh` | `devcheck` | Checks whether a development tool is available in `PATH` and displays its version when supported. |
| `healthcheck.sh` | `healthcheck` | Reports CPU load, RAM usage, disk usage, GPU information when available, connectivity, IP addresses, and the default gateway. |
| `portcheck.sh` | `portcheck` | Checks whether a specified TCP port accepts connections on localhost. |
| `usercheck.sh` | `usercheck` | Lists likely interactive user accounts using UID and login-shell filters, showing usernames, UIDs, home directories, and shells. |

### `security/` — Network Security

| Script | Command | Description |
|---|---|---|
| `netaudit.sh` | `netaudit` | Displays network interfaces, IP addresses, the default gateway, and listening TCP ports. Highlights TCP listeners bound to wildcard addresses for further security review. |

### `sysadmin/` — System Administration

| Contents | Command | Description |
|---|---|---|
| No scripts documented yet | — | Reserved for future system administration and automation tools. |

### `workbench/` — Development Workspace

| Contents | Command | Description |
|---|---|---|
| No scripts documented yet | — | Workspace for experiments, prototypes, and tools under development. |

## Configuration and Project Files

| File or directory | Description |
|---|---|
| `config/apps.conf.example` | Stores registered application names and their executable paths for the application-management commands(example of app.conf). |
| `assets/logo.png` | Contains the project logo displayed in the README. |
| `LICENSE` | Defines the project's licensing terms. |
| `README.md` | Documents the project structure and available utilities. |

## Project Goals

- Automate repetitive Linux tasks using Bash.
- Simplify application management from the command line.
- Monitor system resources and troubleshoot common issues.
- Understand Linux networking and basic security auditing.
- Build modular, reusable, and maintainable command-line utilities.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
