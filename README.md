# 🐧 Linux IT Operations Lab

**A comprehensive learning and reference guide for Linux system administration, IT operations, and cybersecurity fundamentals.**

> *From basics to advanced: Master Linux file systems, permissions, scripting, and IT operations automation.*

---

## 📚 Overview

This repository is a **practical learning lab** designed for IT professionals transitioning into Linux-based IT Operations and Cybersecurity roles. It combines educational exercises with real-world scripts and configurations used in professional environments.

**Perfect for:**
- 🎓 Learning Linux fundamentals
- 🛠️ IT Operations professionals
- 🔐 Cybersecurity enthusiasts
- 📈 Career development in IT infrastructure
- 🔧 System administration basics

---

## 🎯 Learning Path

### 🟢 **Level 1: Foundations** (Beginner)
- Linux file system hierarchy
- Basic commands and navigation
- File permissions and ownership
- User and group management
- Basic text processing

### 🟡 **Level 2: Intermediate** (Intermediate)
- Shell scripting fundamentals
- System administration basics
- Process management
- Package management
- Log analysis and monitoring

### 🔴 **Level 3: Advanced** (Advanced)
- Network configuration
- Security hardening
- Automation and orchestration
- Performance tuning
- Incident response basics

---

## 📁 Repository Structure

```
linux-it-ops-lab/
│
├── 📖 README.md                          # This file
├── 📋 LEARNING_PATH.md                   # Structured learning guide
├── 📝 QUICK_REFERENCE.md                 # Command cheat sheet
│
├── 🟢 01-Foundations/
│   ├── 01-File-System/
│   │   ├── filesystem-hierarchy.md       # Linux FHS explained
│   │   ├── exercises.md                  # Practical exercises
│   │   └── solutions.md                  # Solutions & explanations
│   │
│   ├── 02-Basic-Commands/
│   │   ├── navigation.md                 # cd, ls, pwd, etc.
│   │   ├── file-operations.md            # cp, mv, rm, touch
│   │   ├── exercises.md                  # Hands-on practice
│   │   └── solutions.sh                  # Command examples
│   │
│   ├── 03-Permissions/
│   │   ├── permissions-explained.md      # chmod, chown, umask
│   │   ├── exercises.md                  # Permission scenarios
│   │   ├── solutions.md                  # Detailed solutions
│   │   └── permissions-cheatsheet.txt    # Quick reference
│   │
│   └── 04-Users-Groups/
│       ├── user-management.md            # useradd, usermod, userdel
│       ├── group-management.md           # groupadd, groupmod
│       ├── exercises.md                  # Practical scenarios
│       └── solutions.sh                  # Command examples
│
├── 🟡 02-Intermediate/
│   ├── 01-Shell-Scripting/
│   │   ├── bash-basics.md                # Variables, loops, conditionals
│   │   ├── functions.md                  # Writing reusable functions
│   │   ├── error-handling.md             # Error handling best practices
│   │   ├── exercises/
│   │   │   ├── exercise-1.sh             # Simple scripts
│   │   │   ├── exercise-2.sh             # Intermediate scripts
│   │   │   └── solutions/
│   │   └── scripts/
│   │       ├── backup-script.sh          # Automated backups
│   │       ├── log-analyzer.sh           # Log analysis
│   │       └── system-health.sh          # System monitoring
│   │
│   ├── 02-System-Administration/
│   │   ├── process-management.md         # ps, top, kill, systemctl
│   │   ├── package-management.md         # apt, yum, dnf
│   │   ├── service-management.md         # systemd, services
│   │   ├── exercises.md                  # Admin scenarios
│   │   └── solutions.sh                  # Command examples
│   │
│   ├── 03-Log-Analysis/
│   │   ├── log-locations.md              # Where logs are stored
│   │   ├── log-analysis.md               # grep, awk, sed
│   │   ├── exercises.md                  # Log analysis tasks
│   │   └── scripts/
│   │       ├── parse-logs.sh             # Log parsing script
│   │       └── alert-generator.sh        # Alert on patterns
│   │
│   └── 04-Monitoring/
│       ├── system-monitoring.md          # CPU, memory, disk
│       ├── network-monitoring.md         # netstat, ss, tcpdump
│       ├── exercises.md                  # Monitoring tasks
│       └── scripts/
│           ├── monitor-resources.sh      # Resource monitoring
│           └── network-stats.sh          # Network statistics
│
├── 🔴 03-Advanced/
│   ├── 01-Networking/
│   │   ├── network-basics.md             # TCP/IP, DNS, DHCP
│   │   ├── network-configuration.md      # ifconfig, ip, routing
│   │   ├── firewall-basics.md            # iptables, firewalld
│   │   ├── exercises.md                  # Network scenarios
│   │   └── configs/
│   │       ├── network-config.txt        # Network setup examples
│   │       └── firewall-rules.sh         # Firewall configuration
│   │
│   ├── 02-Security/
│   │   ├── security-hardening.md         # Security best practices
│   │   ├── ssh-security.md               # SSH configuration
│   │   ├── file-integrity.md             # Checksums, AIDE
│   │   ├── exercises.md                  # Security scenarios
│   │   └── scripts/
│   │       ├── security-audit.sh         # Security audit script
│   │       └── ssh-hardening.sh          # SSH hardening
│   │
│   ├── 03-Automation/
│   │   ├── cron-jobs.md                  # Scheduling with cron
│   │   ├── systemd-timers.md             # Modern scheduling
│   │   ├── exercises.md                  # Automation tasks
│   │   └── scripts/
│   │       ├── automated-backup.sh       # Backup automation
│   │       └── maintenance-tasks.sh      # Scheduled maintenance
│   │
│   └── 04-Performance/
│       ├── performance-tuning.md         # Optimization basics
│       ├── disk-optimization.md          # Disk performance
│       ├── exercises.md                  # Performance tasks
│       └── scripts/
│           ├── performance-check.sh      # Performance analysis
│           └── disk-cleanup.sh           # Disk optimization
│
├── 🛠️ Scripts/
│   ├── utils/
│   │   ├── common-functions.sh           # Reusable functions
│   │   └── logging-functions.sh          # Logging utilities
│   │
│   ├── admin/
│   │   ├── user-management.sh            # User admin script
│   │   ├── disk-management.sh            # Disk admin script
│   │   └── service-manager.sh            # Service management
│   │
│   ├── monitoring/
│   │   ├── system-health.sh              # System health check
│   │   ├── disk-usage.sh                 # Disk usage report
│   │   └── network-check.sh              # Network diagnostics
│   │
│   └── security/
│       ├── security-scan.sh              # Security scanning
│       ├── log-audit.sh                  # Log auditing
│       └── backup-verify.sh              # Backup verification
│
├── 📚 Cheat-Sheets/
│   ├── commands-cheatsheet.md            # Essential commands
│   ├── permissions-cheatsheet.md         # Permission reference
│   ├── scripting-cheatsheet.md           # Bash scripting reference
│   ├── networking-cheatsheet.md          # Network commands
│   └── security-cheatsheet.md            # Security commands
│
├── 🔗 Resources/
│   ├── useful-links.md                   # External resources
│   ├── books-recommendations.md          # Recommended reading
│   └── certifications.md                 # Relevant certifications
│
└── 📄 LICENSE                            # MIT License
```

---

## 🚀 Quick Start

### Prerequisites
- Linux system (Ubuntu, CentOS, Debian, etc.)
- Bash shell
- Basic terminal knowledge
- Text editor (nano, vim, or VS Code)

### Getting Started

1. **Clone the repository:**
```bash
git clone https://github.com/georgemir/linux-it-ops-lab.git
cd linux-it-ops-lab
```

2. **Start with foundations:**
```bash
cd 01-Foundations/01-File-System
cat filesystem-hierarchy.md
```

3. **Work through exercises:**
```bash
# Read the exercise
cat exercises.md

# Try solving them yourself
# Then check solutions
cat solutions.md
```

4. **Practice with scripts:**
```bash
cd ../../Scripts
chmod +x *.sh
./system-health.sh
```

---

## 📖 How to Use This Lab

### For Learning:
1. Read the theory/documentation files
2. Complete the exercises
3. Compare with solutions
4. Experiment and modify examples
5. Move to the next level

### For Reference:
- Use cheat sheets for quick command lookup
- Reference scripts for real-world examples
- Check solutions for best practices

### For IT Operations:
- Use provided scripts in your environment
- Adapt scripts to your needs
- Combine scripts for automation
- Integrate with monitoring systems

---

## 📊 Topics Covered

| Topic | Level | Status |
|-------|-------|--------|
| File System Hierarchy | Beginner | ✅ |
| Basic Commands | Beginner | ✅ |
| Permissions & Ownership | Beginner | ✅ |
| Users & Groups | Beginner | ✅ |
| Shell Scripting | Intermediate | ✅ |
| System Administration | Intermediate | ✅ |
| Log Analysis | Intermediate | ✅ |
| Monitoring | Intermediate | ✅ |
| Networking | Advanced | ✅ |
| Security Hardening | Advanced | ✅ |
| Automation | Advanced | ✅ |
| Performance Tuning | Advanced | ✅ |

---

## 🎓 Learning Outcomes

After completing this lab, you will be able to:

✅ Navigate and manage Linux file systems efficiently
✅ Understand and configure file permissions and ownership
✅ Create and manage users and groups
✅ Write and debug bash scripts
✅ Manage processes and services
✅ Analyze logs and troubleshoot issues
✅ Monitor system performance
✅ Configure networking basics
✅ Implement security hardening
✅ Automate routine tasks
✅ Optimize system performance
✅ Respond to incidents

---

## 💡 Best Practices

### When Learning:
- 🔍 Understand concepts before memorizing commands
- 🧪 Experiment in a safe environment
- 📝 Take notes and create your own cheat sheets
- 🔄 Repeat exercises until comfortable
- 🤝 Share knowledge with others

### When Using Scripts:
- ✅ Always test in non-production first
- 📋 Read and understand scripts before running
- 🔐 Check permissions and ownership
- 📊 Monitor script execution
- 🔄 Keep backups before making changes

---

## 🔗 Connect & Contribute

- 💼 **LinkedIn:** [linkedin.com/in/george-miron](https://linkedin.com/in/george-miron)
- 📧 **Email:** mi.geo76@gmail.com
- 🐙 **GitHub:** [@georgemir](https://github.com/georgemir)

### Contributing
Found an issue? Have a suggestion? Feel free to:
- Open an issue
- Submit a pull request
- Share feedback

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Linux Foundation
- Cisco Networking Academy
- ISC2 Cybersecurity Community
- Open Source Community

---

## 📌 Disclaimer

These materials are for educational purposes. Always:
- Test in safe environments first
- Follow your organization's policies
- Respect security and compliance requirements
- Use knowledge responsibly

---

<div align="center">

### 🎯 Start Your Linux Journey Today!

*"Master Linux. Master IT Operations. Master Your Career."*

**[Start Learning →](01-Foundations/01-File-System/filesystem-hierarchy.md)**

</div>
