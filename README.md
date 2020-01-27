# Saluto

## Litarvan `lightdm-webkit2-greeter` Theme Fork

[toc]

## Installation

In your shell…

### Clone

```sh
git clone https://github.com/Demonstrandum/Saluto.git
```

### Build & Install

```sh
cd Saluto
sh ./install.sh
```

You should have a read through `./install.sh` so you know what you’re running, and what you need your password for.

### Editing LightDM Configurations

- First make sure you’re using LightDM and `lightdm-webkit2-greeter` (which can both likely be installed with your system package manager).

- Edit `/etc/lightdm/lightdm.conf` to use `lightdm-webkit2-greeter`:

  ```toml
  [Seat:*]
  greeter-session=lightdm-webkit2-greeter
  ```

- Edit `/etc/lightdm/lightdm-webkit2-greeter.conf` to use this theme:

  ```toml
  [greeter]
  webkit_theme=saluto
  ```


## Live Preview

A live preview of what your greeter may look like may be viewed by either:

- Opening up the `index.html` file in the `dist/` folder generated after the install script has run.
- Launching the `lightdm-webkit2-greeter` executable, likely in your `PATH`, from your terminal or otherwise.
- Viewing this Github–Pages site: 

## Screenshots

### Splash Screen

![splash](https://github.com/Demonstrandum/Saluto/blob/master/demo/splash.png?raw=true)

### Login Screen

![login](https://github.com/Demonstrandum/Saluto/blob/master/demo/login.png?raw=true)

### Login Screen with Clock

![login-with-clock](https://github.com/Demonstrandum/lightdm-eh8/blob/master/demo/login-clock.png?raw=true)

### Settings Screen

![settings](https://github.com/Demonstrandum/Saluto/blob/master/demo/settings.png?raw=true)
