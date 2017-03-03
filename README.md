# Windows-7-Activator (dev branch - not currently working)
This is a batch script for activating Windows 7 using an OEM certificate. For computers that come with a Windows 8/10 sticker but have downgrade rights to Windows 7 Pro. This allows you activate it after doing a clean install. It's useful in conjunction with SetupComplete.cmd if you're setting up a Windows 7 deployment image.

You can also use it to install a retail or volume license key. 

# Roadmap

The following features are being developed for the script:

- Multiple edition support (Starter, Home Prem/Basic and Ultimate) ✔
- Detect incompatible Windows versions or editions ✔
- Autodetect failed activation and alternative certificate attempt ✔
- Autodetect manufacturer (if possible)
- Eventually will be ported over to Powershell or VB.

Please suggest any features you'd like to see.

##Read This Notice:##
The use of this script assumes you have a device with valid installation or downgrade rights to Windows 7 Professional, or a valid Windows 7 retail or volume product key. The use of this script may be a violation of specific manufacturer agreements, so it is best to check with your manufacturer before using this script. The author assumes no responsibility for any misuse or any liability for any damages that may result from the use of this script.

The digital certificates included are property of their respective owners. They were obtained from the Dell support forums here: http://en.community.dell.com/support-forums/software-os/m/microsoft_os/20443565

##Usage:

1. Download the ZIP and extract everything to a folder.
2. Run Win7ProActivator.bat
3. Allow UAC when prompted.
4. Follow the prompts.

##Supported Windows 7 Editions:
- Starter
- Home Basic
- Home Premium
- Professional
- Ultimate

##Supported Manufacturers:
- Acer/Gateway/Packard
- Alienware
- Asus
- Dell
- Fujitsu
- HP/Compaq
- Lenovo/IBM
- Samsung
- Sony
- Toshiba
