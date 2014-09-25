#!/sbin/sh
# ========================================
# script for DX ModPack
# ========================================
# Created originally by unCoRrUpTeD - Modded by xpirt

FILE="/system/build.prop"

mount /system
mount /data

if [ -f /system/build.prop.bak ]; 
  then
    rm -rf $FILE
    cp $FILE.bak $FILE
  else
    cp $FILE $FILE.bak
fi

for mod in xpirt;
  do
    for prop in `cat /tmp/$mod`;do
      export newprop=$(echo ${prop} | cut -d '=' -f1)
      sed -i "/${newprop}/d" /system/build.prop
      echo $prop >> /system/build.prop 
    done
done
