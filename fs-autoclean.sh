# 
# Autoclean file share files created/changed more then N days ago
# except base directory structure.
#
# Alexander Sakharuk <saharuk.alexander@gmail.com>,  2019
# Licensed under MIT licence
#
# Add to crontab (crontab -e)
# 0 19 * * * /<path>/fs-autoclean.sh
#

FSPATH="/mnt/smb/share"
FSLOG="/mnt/smb/data/fs-autoclean.log"
RDAYS=7

# First clean files modified more then N days ago, then clean empty 
# folders created by users (mask 0755).
echo "`date '+%Y-%m-%d %H:%M:%S'` Autoclean started..." | tee -a $FSLOG
find $FSPATH -ctime +"${RDAYS}" -type f -delete -print | tee -a $FSLOG &&
find $FSPATH -empty -type d -perm 0775 -delete -print | tee -a $FSLOG
echo "Done" | tee -a $FSLOG
echo "-----------------------------------------------------">> $FSLOG
echo >> $FSLOG