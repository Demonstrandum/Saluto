# Saluto

## Litarvan `lightdm-webkit2-greeter` fork

[toc]

![](demo.png)

## General tips
1. Make sure you have node and npm on your machine. Run ```npm i``` prior to ```install.sh``` to install npm dependencies. This step is generally only necessary for first-time setup.
1. The theme pulls ```~/Pictures/Wallpapers/background.png``` to the ```/usr/share/backgrounds``` folder. You can disable this functionality by uncommenting the respective lines in ```install.sh```
1. To attain the same settings as the unixporn post, you'll need to disable the splash text and enable rounded avatars.

### Do I really have to reboot after I modify and rebuild the theme to see my changes?

Well yes, but actually no if you just want to test out new stuff! Because of the way Vue is built by npm, I don't think there's a good way to directly modify the theme through, say, a .conf file. This being said, one way I tested changes without having to recompile, log out, and log back in again was to simply look at ```dist/index.html``` (this should appear after you build) to view the greeter in my browser!

### I have multiple desktop environments and want to select one at login
Uncomment line 36 in ```src/views/Login.vue``` to turn on DE selection. I only use Xfce so I removed this functionality since it was unnecessary for me.
