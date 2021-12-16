@ECHO OFF
PATH=%PATH%;"%SYSTEMROOT%\System32"
echo 0riole-Flasher starts...
echo Renaming files...
ren bootloader*.img bootloader.img
ren radio*.img radio.img
ren image*.zip image.zip
ren magisk*.img magiskboot.img
echo Let's start flashing...
ping -n 5 127.0.0.1 >nul
adb reboot bootloader
echo The device will reboot various times...
ping -n 5 127.0.0.1 >nul
fastboot flash bootloader bootloader.img --slot all
fastboot reboot bootloader
ping -n 5 127.0.0.1 >nul
fastboot flash radio radio.img --slot all
fastboot reboot bootloader
ping -n 5 127.0.0.1 >nul
fastboot update image.zip
ping -n 5 127.0.0.1 >nul
echo Please wait...
ping -n 30 127.0.0.1 >nul
adb kill-server
ping -n 5 127.0.0.1 >nul
echo Please wait...
adb start-server
ping -n 5 127.0.0.1 >nul
echo Please wait...
ping -n 5 127.0.0.1 >nul
adb reboot bootloader
ping -n 5 127.0.0.1 >nul
fastboot flash boot magiskboot.img --slot all
ping -n 5 127.0.0.1 >nul
fastboot reboot
echo Cleaning up platform-tools folder...
del bootloader.img
del radio.img
del image.zip
del magiskboot.img
ping -n 5 127.0.0.1 >nul
echo All done...
echo Press any key to exit...
pause >nul
exit
