#!/sbin/sh
# ========================================
# script for modPack
# ========================================
# Created by lyapota

LOG_FILE=/sdcard/modpack/zipalign_modpack.log
ZIPALIGN=/sdcard/modpack/zipalign 

if [ -e $LOG_FILE ]; then
    rm $LOG_FILE;
fi;
echo "<---- $( date +"%d.%m.%Y %H:%M:%S" )" | tee -a $LOG_FILE;

echo "For system apk's..." | tee -a $LOG_FILE;
for filename in Prism.apk SystemUI.apk EQSReorder.apk HtcSoundEnhancerSetting.apk Settings.apk HtcMusic.apk Mail.apk WeatherAnimation.apk Fusion.apk ; do
    apk=/system/app/$filename;

    if [ -e $apk ]; then
        $ZIPALIGN -c 4 $apk;
        ZIPCHECK=$?;
        if [ $ZIPCHECK -eq 1 ]; then
            echo ZipAligning $(basename $apk) | tee -a $LOG_FILE;
            $ZIPALIGN -f 4 $apk /cache/$(basename $apk);
            if [ -e /cache/$(basename $apk) ]; then
                cp -f -p /cache/$(basename $apk) $apk | tee -a $LOG_FILE;
                rm /cache/$(basename $apk);
            else
                echo ZipAligning $(basename $apk) Failed | tee -a $LOG_FILE;
            fi;
        else
            echo ZipAlign already completed on $apk | tee -a $LOG_FILE;
        fi;
    fi;
done;

echo "For framework apk's..." | tee -a $LOG_FILE;
for filename in framework-res.apk ; do
    apk=/system/framework/$filename;

    $ZIPALIGN -c 4 $apk;
    ZIPCHECK=$?;
    if [ $ZIPCHECK -eq 1 ]; then
        echo ZipAligning $(basename $apk) | tee -a $LOG_FILE;
        $ZIPALIGN -f 4 $apk /cache/$(basename $apk);
        if [ -e /cache/$(basename $apk) ]; then
            cp -f -p /cache/$(basename $apk) $apk | tee -a $LOG_FILE;
            rm /cache/$(basename $apk);
        else
            echo ZipAligning $(basename $apk) Failed | tee -a $LOG_FILE;
        fi;
    else
        echo ZipAlign already completed on $apk | tee -a $LOG_FILE;
    fi;
done;

echo "---->" | tee -a $LOG_FILE;
