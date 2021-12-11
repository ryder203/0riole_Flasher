@ECHO OFF
PATH=%PATH%;"%SYSTEMROOT%\System32"
adb reboot bootloader
ping -n 5 127.0.0.1 >nul
fastboot flash bootloader bootloader.img --slot all
fastboot reboot bootloader
ping -n 5 127.0.0.1 >nul
fastboot flash radio radio.img --slot all
fastboot reboot bootloader
ping -n 5 127.0.0.1 >nul
fastboot update --disable-verity --disable-verification image.zip
ping -n 5 127.0.0.1 >nul
echo Please wait...
ping -n 25 127.0.0.1 >nul
adb kill-server
ping -n 5 127.0.0.1 >nul
adb start-server
ping -n 5 127.0.0.1 >nul
echo Please wait...
ping -n 5 127.0.0.1 >nul
adb reboot bootloader
ping -n 5 127.0.0.1 >nul
fastboot flash boot magiskboot.img --slot all
ping -n 5 127.0.0.1 >nul
fastboot reboot
echo All done...
echo Press any key to exit...
pause >nul
exit
