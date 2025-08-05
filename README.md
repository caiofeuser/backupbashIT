# Linux Backup Script

A Bash script to create automated, compressed, and rotated backups of specified directories.

### Features
* **Configurable:** Set source directories and a backup destination.
* **Timestamped:** Creates `.tar.gz` archives with the current date and time.
* **Rotation:** Automatically deletes backups older than a set number of days.
* **Exclusions:** Supports excluding specific files and folders.

---

## 1. Setup

Place the script in a system path and make it executable.

```bash
# Move the script
sudo mv system-backup.sh /usr/local/sbin/system-backup

# Make it executable
sudo chmod +x /usr/local/sbin/system-backup

# To run manually
sudo /usr/local/sbin/system-backup
```


--- (if needed) ---
## 2. Configuration
Edit the variables at the top of the script (sudo nano /usr/local/sbin/system-backup):

`SOURCE_DIRS`: Directories to back up, separated by spaces.

i.e: SOURCE_DIRS="/home/inspire/ /etc"

`DEST_DIR`: Where to save the backups.

⚠️ WARNING: Must be on a different physical drive (external USB, NAS, etc.).
i.e: DEST_DIR="/media/inspire/MyBackupDrive/backups"

`DAYS_TO_KEEP`: Automatically deletes backups older than this many days.

i.e: DAYS_TO_KEEP=7

### To schedule the backup (using cron)

```bash
# Open cron tab
sudo crontab -e

# Add this line to the file:
0 4 * * 0 /usr/local/sbin/system-backup > /var/log/system-backup.log 2>&1
```
