#!/sbin/sh
# ========================================
# script for modPack
# ========================================
# Created by lyapota

LOG_FILE=/sdcard/modpack/tweaks_modpack.log
DB=/data/data/com.android.providers.settings/databases/settings.db
SQL=/sdcard/modpack/sqlite3

SETTINGS=$1
TWEAK=$2
VALUE=$3

echo "" | tee -a $LOG_FILE;
echo "<---- $SETTINGS $TWEAK $VALUE $( date +"%d.%m.%Y %H:%M:%S" )" | tee -a $LOG_FILE;

read_sys_setting()
{
  PARAM=$1
  DEFVALUE=$2
  if [ ! -e $DB ]; then
	echo "$DEFVALUE";
  else
  	RETVALUE=`$SQL $DB "SELECT value FROM system WHERE name LIKE '$PARAM';"`;
  	if [ "$RETVALUE" = "" ]; then
        	echo "$DEFVALUE";
  	else
		echo "$RETVALUE";
	fi;
  fi;
}

read_glob_setting()
{
  PARAM=$1
  DEFVALUE=$2
  if [ ! -e $DB ]; then
	echo "$DEFVALUE";
  else
  	RETVALUE=`$SQL $DB "SELECT value FROM global WHERE name LIKE '$PARAM';"`;
  	if [ "$RETVALUE" = "" ]; then
        	echo "$DEFVALUE";
  	else
		echo "$RETVALUE";
	fi;
  fi;
}

read_sec_setting()
{
  PARAM=$1
  DEFVALUE=$2
  if [ ! -e $DB ]; then
	echo "$DEFVALUE";
  else
  	RETVALUE=`$SQL $DB "SELECT value FROM sequre WHERE name LIKE '$PARAM';"`;
  	if [ "$RETVALUE" = "" ]; then
        	echo "$DEFVALUE";
  	else
		echo "$RETVALUE";
	fi;
  fi;
}

write_sys_setting()
{
  PARAM=$1
  NEWVALUE=$2
  if [ ! -e $DB ]; then
	echo "ERROR: DataBase $DB not found!" | tee -a $LOG_FILE;
  else
  	RETVALUE=`$SQL $DB "SELECT value FROM system WHERE name LIKE '$PARAM';"`;
  	if [ "$RETVALUE" = "" ]; then
        	echo "INSERT: value $NEWVALUE" | tee -a $LOG_FILE;
        	$SQL $DB "INSERT INTO system(name, value) VALUES('$PARAM', '$NEWVALUE');";
  	else
        	echo "UPDATE: value $RETVALUE to $NEWVALUE" | tee -a $LOG_FILE;
		$SQL $DB "UPDATE system SET value = '$NEWVALUE' WHERE name = '$PARAM';";
	fi;
  fi;
}

write_glob_setting()
{
  PARAM=$1
  NEWVALUE=$2
  if [ ! -e $DB ]; then
	echo "ERROR: DataBase $DB not found!" | tee -a $LOG_FILE;
  else
  	RETVALUE=`$SQL $DB "SELECT value FROM global WHERE name LIKE '$PARAM';"`;
  	if [ "$RETVALUE" = "" ]; then
        	echo "INSERT: value $NEWVALUE" | tee -a $LOG_FILE;
        	$SQL $DB "INSERT INTO global(name, value) VALUES('$PARAM', '$NEWVALUE');";
  	else
        	echo "UPDATE: value $RETVALUE to $NEWVALUE" | tee -a $LOG_FILE;
		$SQL $DB "UPDATE global SET value = '$NEWVALUE' WHERE name = '$PARAM';";
	fi;
  fi;
}

write_sec_setting()
{
  PARAM=$1
  NEWVALUE=$2
  if [ ! -e $DB ]; then
	echo "ERROR: DataBase $DB not found!" | tee -a $LOG_FILE;
  else
  	RETVALUE=`$SQL $DB "SELECT value FROM secure WHERE name LIKE '$PARAM';"`;
  	if [ "$RETVALUE" = "" ]; then
        	echo "INSERT: value $NEWVALUE" | tee -a $LOG_FILE;
        	$SQL $DB "INSERT INTO secure(name, value) VALUES('$PARAM', '$NEWVALUE');";
  	else
        	echo "UPDATE: value $RETVALUE to $NEWVALUE" | tee -a $LOG_FILE;
		$SQL $DB "UPDATE secure SET value = '$NEWVALUE' WHERE name = '$PARAM';";
	fi;
  fi;
}

#### MAIN #########################################################

if [ "$SETTINGS" = "sys" ]; then
  write_sys_setting $TWEAK "$VALUE";
fi;

if [ "$SETTINGS" = "glob" ]; then
  write_glob_setting $TWEAK "$VALUE";
fi;

if [ "$SETTINGS" = "sec" ]; then
  write_sec_setting $TWEAK "$VALUE";
fi;

echo "---->" | tee -a $LOG_FILE;

