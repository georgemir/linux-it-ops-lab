# 📝 File System Exercises

## Exercise 1: Exploring the Root Directory

### Task:
1. Navigate to the root directory
2. List all directories in the root
3. Identify which directories are essential for system boot
4. Check the permissions of key directories

### Questions:
- What is the purpose of `/boot`?
- Which directories are world-readable?
- What permissions does `/root` have and why?

---

## Exercise 2: Understanding Directory Permissions

### Task:
1. Navigate to `/home`
2. List the permissions of user directories
3. Try to access another user's home directory
4. Check your own home directory permissions

### Questions:
- Why can't you access other users' home directories?
- What do the permissions `700` mean?
- What would happen if `/home/username` had permissions `755`?

---

## Exercise 3: Navigating with Absolute and Relative Paths

### Task:
1. Start in your home directory
2. Navigate to `/var/log` using absolute path
3. Navigate back to home using relative path (`..`)
4. Navigate to `/etc` and then back using `-`

### Commands to try:
```bash
pwd
cd /var/log
pwd
cd ~
cd -
```

### Questions:
- What's the difference between absolute and relative paths?
- When should you use each type?
- Why are absolute paths better in scripts?

---

## Exercise 4: Creating Directory Structure

### Task:
Create the following directory structure in your home directory:

```
projects/
├── linux-lab/
│   ├── scripts/
│   ├── configs/
│   └── logs/
├── networking/
│   ├── cisco/
│   └── linux/
└── security/
    ├── tools/
    └── notes/
```

### Commands to use:
- `mkdir` - Create single directory
- `mkdir -p` - Create nested directories
- `ls -R` - View recursive directory structure

### Questions:
- What does the `-p` flag do?
- How would you create this structure with one command?
- What are the default permissions for new directories?

---

## Exercise 5: Understanding /etc Directory

### Task:
1. Navigate to `/etc`
2. List the contents
3. Find and examine these files:
   - `passwd` - User accounts
   - `shadow` - Password hashes
   - `hostname` - System hostname
   - `fstab` - File system table

### Commands:
```bash
cd /etc
ls -la
cat passwd
cat hostname
```

### Questions:
- What information is in `/etc/passwd`?
- Why is `/etc/shadow` not readable by regular users?
- What is the purpose of `/etc/fstab`?

---

## Exercise 6: Exploring /var Directory

### Task:
1. Navigate to `/var`
2. Check `/var/log` for system logs
3. Check `/var/tmp` for temporary files
4. Compare `/tmp` and `/var/tmp`

### Commands:
```bash
cd /var
ls -la
cd log
ls -la
```

### Questions:
- What's the difference between `/tmp` and `/var/tmp`?
- Why are logs stored in `/var/log`?
- What happens to files in `/tmp` on reboot?

---

## Exercise 7: Disk Usage Analysis

### Task:
1. Check total disk usage with `df -h`
2. Check directory sizes with `du -sh`
3. Find the largest directories in `/var`
4. Find the largest directories in `/home`

### Commands:
```bash
df -h
du -sh /var/*
du -sh /home/*
du -sh /* | sort -h
```

### Questions:
- Which directory uses the most space?
- What's the difference between `df` and `du`?
- How would you find large files?

---

## Exercise 8: File System Hierarchy Challenge

### Task:
For each file/directory below, identify:
1. Its location in the FHS
2. Its purpose
3. Its typical permissions
4. Who should have access

**Files/Directories:**
- System kernel
- User password file
- System logs
- User home directory
- Temporary files
- System configuration
- User commands
- System commands

### Questions:
- Why are some directories restricted?
- What would happen if permissions were wrong?
- How do permissions affect system security?

---

## Exercise 9: Navigating with Shortcuts

### Task:
Practice using these shortcuts:

```bash
# Go to home directory
cd ~

# Go to previous directory
cd -

# Go to parent directory
cd ..

# Go to parent's parent
cd ../..

# List home directory from anywhere
ls ~

# List parent directory from anywhere
ls ..
```

### Questions:
- When is `cd -` useful?
- How would you go up 3 levels?
- What does `~` expand to?

---

## Exercise 10: System vs User Directories

### Task:
1. List files in `/bin` (system binaries)
2. List files in `/usr/bin` (user binaries)
3. List files in `/usr/local/bin` (local binaries)
4. Compare the contents

### Commands:
```bash
ls /bin | head -20
ls /usr/bin | head -20
ls /usr/local/bin
```

### Questions:
- What's the difference between these directories?
- Where would you install a custom script?
- Why is this organization important?

---

## 🎯 Challenge Exercises

### Challenge 1: Create a Project Structure
Create a complete project directory structure for a Linux learning lab with:
- Documentation folder
- Scripts folder with subfolders for different script types
- Configuration folder
- Logs folder
- Data folder

### Challenge 2: Analyze Your System
Create a report showing:
- Total disk space
- Used vs available space
- Largest directories
- Number of files in key directories

### Challenge 3: Permission Audit
Check and document:
- Permissions of all directories in `/home`
- Permissions of all directories in `/etc`
- Any unusual permissions
- Security implications

---

## 💡 Tips for Success

1. **Use `pwd` frequently** - Always know where you are
2. **Use `ls -la`** - See all files and permissions
3. **Use `man` command** - Read documentation
4. **Experiment safely** - Use your home directory
5. **Take notes** - Document what you learn

---

## 📚 Related Topics

- File Permissions (next section)
- User and Group Management
- File Operations
- System Administration

---

## ✅ Completion Checklist

- [ ] Completed Exercise 1
- [ ] Completed Exercise 2
- [ ] Completed Exercise 3
- [ ] Completed Exercise 4
- [ ] Completed Exercise 5
- [ ] Completed Exercise 6
- [ ] Completed Exercise 7
- [ ] Completed Exercise 8
- [ ] Completed Exercise 9
- [ ] Completed Exercise 10
- [ ] Completed all Challenge Exercises
- [ ] Understood all concepts
- [ ] Ready for next section

---

**Next:** [Solutions](solutions.md)
