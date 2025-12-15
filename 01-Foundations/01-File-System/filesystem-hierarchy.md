# 📁 Linux File System Hierarchy (FHS)

## Overview

The Linux File System Hierarchy Standard (FHS) defines the directory structure and naming conventions in Linux. Understanding this is crucial for IT Operations professionals.

---

## 🏗️ Root Directory Structure

```
/
├── bin/              → Essential user command binaries
├── boot/             → Boot loader files and kernel
├── dev/              → Device files
├── etc/              → System configuration files
├── home/             → User home directories
├── lib/              → System libraries
├── media/            → Mount points for removable media
├── mnt/              → Temporary mount points
├── opt/              → Optional software packages
├── proc/             → Process information (virtual)
├── root/             → Root user home directory
├── run/              → Runtime data
├── sbin/             → System binaries (root only)
├── srv/              → Service data
├── sys/              → System information (virtual)
├── tmp/              → Temporary files
├── usr/              → User programs and data
└── var/              → Variable data (logs, caches, etc.)
```

---

## 📋 Detailed Directory Descriptions

### `/` - Root Directory
- **Purpose:** Top-level directory of the entire file system
- **Permissions:** 755 (drwxr-xr-x)
- **Owner:** root:root
- **Note:** Everything in Linux is under this directory

### `/bin` - Essential User Binaries
- **Purpose:** Essential command binaries available to all users
- **Examples:** ls, cat, cp, mv, rm, grep, sed, awk
- **Permissions:** 755
- **Note:** These commands are needed for system recovery

### `/boot` - Boot Files
- **Purpose:** Boot loader and kernel files
- **Contents:** vmlinuz (kernel), initrd (initial ramdisk), grub config
- **Permissions:** 755
- **Note:** Critical for system startup

### `/dev` - Device Files
- **Purpose:** Device files for hardware and pseudo-devices
- **Examples:** /dev/sda (disk), /dev/tty (terminal), /dev/null
- **Type:** Character and block devices
- **Note:** Managed by udev in modern systems

### `/etc` - System Configuration
- **Purpose:** System-wide configuration files
- **Examples:** passwd, shadow, fstab, hostname, network configs
- **Permissions:** 755 (files vary)
- **Note:** Critical for system operation

### `/home` - User Home Directories
- **Purpose:** User home directories
- **Structure:** /home/username/
- **Permissions:** 700 (user's own directory)
- **Note:** Each user has their own directory

### `/lib` - System Libraries
- **Purpose:** Essential system libraries
- **Examples:** libc.so, libm.so (math library)
- **Permissions:** 755
- **Note:** Required for system binaries

### `/media` - Removable Media
- **Purpose:** Mount points for removable media
- **Examples:** /media/usb, /media/cdrom
- **Permissions:** 755
- **Note:** Automatically managed by desktop environments

### `/mnt` - Temporary Mount Points
- **Purpose:** Temporary mount points for administrators
- **Examples:** /mnt/backup, /mnt/nfs
- **Permissions:** 755
- **Note:** Manual mount points

### `/opt` - Optional Software
- **Purpose:** Optional software packages
- **Examples:** /opt/google/chrome, /opt/java
- **Permissions:** 755
- **Note:** Third-party applications

### `/proc` - Process Information
- **Purpose:** Virtual file system with process information
- **Examples:** /proc/cpuinfo, /proc/meminfo, /proc/[pid]/
- **Type:** Virtual (in memory)
- **Note:** Read-only, provides system information

### `/root` - Root Home Directory
- **Purpose:** Home directory for root user
- **Permissions:** 700 (rwx------)
- **Note:** Different from /

### `/run` - Runtime Data
- **Purpose:** Runtime data for processes
- **Examples:** /run/systemd, /run/lock
- **Permissions:** 755
- **Note:** Cleared on reboot

### `/sbin` - System Binaries
- **Purpose:** System binaries (usually root only)
- **Examples:** ifconfig, iptables, fdisk, mount
- **Permissions:** 755
- **Note:** Administrative commands

### `/srv` - Service Data
- **Purpose:** Data for services
- **Examples:** /srv/www, /srv/ftp
- **Permissions:** 755
- **Note:** Service-specific data

### `/sys` - System Information
- **Purpose:** Virtual file system with kernel information
- **Examples:** /sys/devices, /sys/class
- **Type:** Virtual (in memory)
- **Note:** Kernel interface

### `/tmp` - Temporary Files
- **Purpose:** Temporary files
- **Permissions:** 1777 (drwxrwxrwt)
- **Note:** Cleared on reboot, world-writable

### `/usr` - User Programs and Data
- **Purpose:** User programs, libraries, and documentation
- **Subdirectories:**
  - `/usr/bin` - User command binaries
  - `/usr/sbin` - User system binaries
  - `/usr/lib` - User libraries
  - `/usr/local` - Locally installed software
  - `/usr/share` - Shared data (docs, man pages)
- **Permissions:** 755

### `/var` - Variable Data
- **Purpose:** Variable data (logs, caches, mail, etc.)
- **Subdirectories:**
  - `/var/log` - System logs
  - `/var/cache` - Cache files
  - `/var/mail` - User mail
  - `/var/spool` - Print and mail queues
  - `/var/tmp` - Temporary files (persistent)
- **Permissions:** 755

---

## 🔐 Typical Permissions

| Directory | Permissions | Owner | Group | Purpose |
|-----------|-------------|-------|-------|---------|
| / | 755 | root | root | Root directory |
| /bin | 755 | root | root | Essential binaries |
| /boot | 755 | root | root | Boot files |
| /dev | 755 | root | root | Device files |
| /etc | 755 | root | root | Configuration |
| /home | 755 | root | root | User homes |
| /lib | 755 | root | root | Libraries |
| /root | 700 | root | root | Root home |
| /tmp | 1777 | root | root | Temp files |
| /var | 755 | root | root | Variable data |

---

## 📊 File System Navigation

### Absolute vs Relative Paths

**Absolute Path:** Starts with `/`
```bash
/home/george/documents/file.txt
/etc/passwd
/var/log/syslog
```

**Relative Path:** Relative to current directory
```bash
documents/file.txt
../other-folder/file.txt
./current-file.txt
```

### Special Path References

| Symbol | Meaning |
|--------|---------|
| `/` | Root directory |
| `~` | Current user's home directory |
| `.` | Current directory |
| `..` | Parent directory |
| `-` | Previous directory |

---

## 🛠️ Common Operations

### Viewing Directory Structure
```bash
# List directory contents
ls -la /

# Tree view (if installed)
tree -L 2 /

# Show disk usage
du -sh /*
```

### Navigating
```bash
# Change directory
cd /home/george

# Go to home directory
cd ~

# Go to previous directory
cd -

# Print working directory
pwd
```

### Creating Directories
```bash
# Create single directory
mkdir documents

# Create nested directories
mkdir -p /home/george/projects/linux-lab

# Create with specific permissions
mkdir -m 700 private-folder
```

---

## 💡 Best Practices

✅ **DO:**
- Keep system directories organized
- Use /home for user files
- Use /opt for third-party software
- Use /var/log for application logs
- Respect directory permissions

❌ **DON'T:**
- Modify system directories unnecessarily
- Store user data in /root
- Put everything in /tmp
- Change permissions on critical directories
- Delete system directories

---

## 🔍 Checking File System

```bash
# View mounted file systems
mount

# Check disk usage
df -h

# Check inode usage
df -i

# View file system type
file -s /dev/sda1

# List block devices
lsblk
```

---

## 📚 Key Takeaways

1. **FHS provides standardization** - All Linux systems follow similar structure
2. **Permissions matter** - Respect directory permissions
3. **Know the critical directories** - /etc, /var, /home, /boot
4. **Use absolute paths in scripts** - More reliable than relative paths
5. **Understand the purpose** - Each directory has a specific role

---

## 🎯 Next Steps

- Practice navigating the file system
- Explore each major directory
- Understand permissions for each directory
- Complete the exercises in `exercises.md`
