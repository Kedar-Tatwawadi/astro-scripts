#!/bin/bash

#This is a simple bash script which downloads the Astronomy Picture of the day 
#from the NASA website and sets it as the wallpaper.
#To automatically update the wallpaper daily, place this script 
#in the /etc/cron.daily/ Directory and give it executable permissions


# Prerequisite: This code uses the wget program.
# So, just check whether the wgetrc is set correctly 
# according to the proxy server, etc.
 
#@author: Kedar Tatwawadi
#@email: ktatwawadi@gmail.com





# apod_webpage : the official astronomy picture of the day webpage by NASA
apod_webpage="http://apod.nasa.gov/apod/astropix.html"
basepath="http://apod.nasa.gov/apod/"

# by default we assume that the apod picture downloaded is saved in the Pictures directory
cd ~/Pictures

# We first just download the basic html page
wget $apod_webpage

# once the basic webpage is downloaded, we search for the apod image PATHNAME using
# sed, grep and tr programs 
imagepath=$(sed -n -e '35p' astropix.html| grep -Po '".*?"'| tr -d '"')
image_weblink=$basepath$imagepath

#We use the image PATHNAME to download the apod image
wget -O apod_image.jpg $image_weblink

#remove temporarily stored astropix.html webpage
rm astropix.html
apod_image_path=file://$(pwd)/apod_image.jpg

#wait for some time
sleep 5
#using gsettings utility we set the desktop background to the apod image!
gsettings set org.gnome.desktop.background picture-uri $apod_image_path

# Thanks:
# sed: http://www.ibm.com/developerworks/library/l-sed1/index.html
# tr: http://stackoverflow.com/questions/4248905/remove-quotes-with-sed
# strings_in_bash: http://stackoverflow.com/questions/4181703/how-can-i-concatenate-string-variables-in-bash
# desktop_background: http://askubuntu.com/questions/156713/change-desktop-background-from-terminal
# cron: http://www.unixgeeks.org/security/newbie/unix/cron-1.html





