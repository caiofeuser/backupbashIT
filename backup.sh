
# Settings section
# 1. Directories you want to back up (spaces to multiple folders).
# i.e: SOURCE_DIRS="/home/backup  /data /var/www/html /etc"
SOURCE_DIRS=""

# 2. Directory where the backups will be saved.
# i.e: DEST_DIR="/backups/daily"

# 3. Number of days that backup files should be kept. (att: files older than this will be deleted.)
DAYS_TO_KEEP=7

# 4. (Optional) Files or directories to be excluded from the backup.
#    -> Use the format --exclude="relative/path"
#    i.e: EXCLUDE_PATTERNS="--exclude='*.log' --exclude='cache'"
EXCLUDE_PATTERNS="--exclude='*.tmp' --exclude='node_modules' --exclude='vendor'"

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

FILENAME="backup-$(date +%Y-%m-%d_%H%M%S).tar.gz"
FINAL_ARCHIVE="$DEST_DIR/$FILENAME"

echo "=============================================="
echo "Starting backup at $(date +'%Y-%m-%d %H:%M:%S')"
echo "Source: $SOURCE_DIRS"
echo "Destination: $FINAL_ARCHIVE"
echo "=============================================="

tar -czpf "$FINAL_ARCHIVE" ${EXCLUDE_PATTERNS} ${SOURCE_DIRS}

# Check if the tar command was successful
if [ $? -eq 0 ]; then
  echo "Backup created successfully: $FINAL_ARCHIVE"
else
  echo "ERROR: Backup creation failed!"
  exit 1
fi

echo "----------------------------------------------"
echo "Removing backups older than $DAYS_TO_KEEP days..."

# Find and delete backup files older than the specified number of days
find "$DEST_DIR" -type f -name "backup-*.tar.gz" -mtime +$DAYS_TO_KEEP -delete

echo "Cleanup complete."
echo "=============================================="
echo "Backup process finished at $(date +'%Y-%m-%d %H:%M:%S')"
echo "=============================================="

exit 0