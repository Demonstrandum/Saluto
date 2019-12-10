# [Live testing (3.0.0)](https://litarvan.github.io/lightdm-webkit-theme-litarvan/)

# Customize release
Backgrounds can be added in /usr/share/backgrounds and chosen in the Theming view (bottom right corner of the Setup view).

Customize the OS logo within `/usr/share/lightdm-webkit/themes/litarvan/img/os.xxxxxxxx.png`

# Installation

## Arch Linux (2.0.X)

```
pacman -S lightdm-webkit-theme-litarvan
```

If not already done, edit `/etc/lightdm/lightdm.conf` and set `greeter-session=lightdm-webkit2-greeter`.
Then edit `/etc/lightdm/lightdm-webkit.conf` and set `theme` or `webkit-theme` to `litarvan`.

## Manual (3.0.0)

* Install lightdm-webkit2-greeter using pacman if not already done
* Unzip the [tar file](https://github.com/Litarvan/lightdm-webkit-theme-litarvan/releases) in `/usr/share/lightdm-webkit/themes/litarvan/`
* Edit `/etc/lightdm/lightdm-webkit2-greeter.conf` and set `theme` or `webkit-theme` to `litarvan`.

# Building

```
$ ./build.sh
```

Will generate a lightdm-webkit-theme-litarvan-VERSION.tar.gz in the current folder.

# Screenshots

![Setup screenshot](https://litarvan.github.io/lightdm-webkit-theme-litarvan/setup_view.png)

![Splash screenshot](https://litarvan.github.io/lightdm-webkit-theme-litarvan/splash_view.png)

![Login screnshot](https://litarvan.github.io/lightdm-webkit-theme-litarvan/login_view.png)

![Desktops screenshot](https://litarvan.github.io/lightdm-webkit-theme-litarvan/desktops_view.png)

![Theming screenshot](https://litarvan.github.io/lightdm-webkit-theme-litarvan/theming_view.png)
