@ECHO OFF
PATH=%PATH%;"%SYSTEMROOT%\System32"
echo 0riole-Flasher v3 starts...
echo Renaming files...
if exist bootloader*.img ren bootloader*.img bootloader.img
if exist radio*.img ren radio*.img radio.img
if exist image*.zip ren image*.zip image.zip
if exist magisk*.img ren magisk*.img magiskboot.img
if exist "bootloader.img" if exist "radio.img"  if exist "image.zip" if exist "magiskboot.img" goto :startflash
if not exist "bootloader.img" goto :bootloaderfilemissing
if not exist "radio.img" goto :radiofilemissing
if not exist "image.zip" goto :imagefilemissing
if not exist "magiskboot.img" goto :magiskbootfilemissing
:startflash
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
fastboot update --skip-reboot image.zip
ping -n 5 127.0.0.1 >nul
echo Please wait...
ping -n 5 127.0.0.1 >nul
fastboot reboot bootloader
ping -n 5 127.0.0.1 >nul
fastboot flash boot magiskboot.img --slot all
ping -n 5 127.0.0.1 >nul
fastboot reboot
:choice
set /P c=Do you want to clean up and delete the update files [Y/N]?
if /I "%c%" EQU "Y" goto :cleanupnow
if /I "%c%" EQU "N" goto :quit
goto :choice
:cleanupnow
del /f bootloader.img radio.img image.zip magiskboot.img
echo Cleaning up platform-tools folder...
ping -n 5 127.0.0.1 >nul
echo All done...
echo Press any key to exit...
pause >nul
exit
:quit
echo Not cleaning up platform-tools folder...
ping -n 5 127.0.0.1 >nul
echo All done...
echo Press any key to exit...
pause >nul
exit
:bootloaderfilemissing
ping -n 3 127.0.0.1 >nul
echo Bootloader file missing...
echo Press any key to exit...
pause >nul
exit
:radiofilemissing
ping -n 3 127.0.0.1 >nul
echo Radio file missing...
echo Press any key to exit...
pause >nul
exit
:imagefilemissing
ping -n 3 127.0.0.1 >nul
echo image.zip file missing...
echo Press any key to exit...
pause >nul
exit
:magiskbootfilemissing
ping -n 3 127.0.0.1 >nul
echo Magisk boot.img file missing...
echo Press any key to exit...
pause >nul
exit
