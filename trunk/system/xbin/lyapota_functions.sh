#!/system/bin/sh
# ========================================
# script for modPack
# ========================================
# Created by lyapota
DB=/data/data/com.android.providers.settings/databases/settings.db

read_sys_setting()
{
  PARAM=$1
  DEFVALUE=$2
  if [ ! -e $DB ]; then
	echo "$DEFVALUE";
  else
  	RETVALUE=`sqlite3 $DB "SELECT value FROM system WHERE name LIKE '$PARAM';"`;
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
  	RETVALUE=`sqlite3 $DB "SELECT value FROM global WHERE name LIKE '$PARAM';"`;
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
  	VALUE=`sqlite3 $DB "SELECT value FROM sequre WHERE name LIKE '$PARAM';"`;
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
	echo "ERROR: DataBase $DB not found!";
  else
  	VALUE=`sqlite3 $DB "SELECT value FROM system WHERE name LIKE '$PARAM';"`;
  	if [ "$VALUE" = "" ]; then
        	sqlite3 $DB "INSERT INTO system(name, value) VALUES('$PARAM', '$NEWVALUE');";
  	else
		sqlite3 $DB "UPDATE system SET value = '$NEWVALUE' WHERE name = '$PARAM';";
	fi;
  fi;
}

write_glob_setting()
{
  PARAM=$1
  NEWVALUE=$2
  if [ ! -e $DB ]; then
	echo "ERROR: DataBase $DB not found!";
  else
  	VALUE=`sqlite3 $DB "SELECT value FROM global WHERE name LIKE '$PARAM';"`;
  	if [ "$VALUE" = "" ]; then
        	sqlite3 $DB "INSERT INTO global(name, value) VALUES('$PARAM', '$NEWVALUE');";
  	else
		sqlite3 $DB "UPDATE global SET value = '$NEWVALUE' WHERE name = '$PARAM';";
	fi;
  fi;
}

write_sec_setting()
{
  PARAM=$1
  NEWVALUE=$2
  if [ ! -e $DB ]; then
	echo "ERROR: DataBase $DB not found!";
  else
  	VALUE=`sqlite3 $DB "SELECT value FROM secure WHERE name LIKE '$PARAM';"`;
  	if [ "$VALUE" = "" ]; then
        	sqlite3 $DB "INSERT INTO secure(name, value) VALUES('$PARAM', '$NEWVALUE');";
  	else
		sqlite3 $DB "UPDATE secure SET value = '$NEWVALUE' WHERE name = '$PARAM';";
	fi;
  fi;
}
