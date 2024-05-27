# acpi_call-fedora
The glorious acpi_call Kernel module for FEDORA !!!!!!!

Compiled with https://github.com/nix-community/acpi_call

## Install : 

Download the rpm from here : [release](https://github.com/MiMillieuh/acpi_call-fedora/releases/)

`sudo rpm -i acpi_call-*.rpm`

modprobe it if not loaded : 

`sudo modprobe acpi_call`

### BlueBuild (UblueOS) : 

Download the ublue-acpi_call.sh from [release](https://github.com/MiMillieuh/acpi_call-fedora/releases/) and put it in your script and post folder.

it's now in `config/scripts` and add the script to you recipe.yml :

```
  - type: script
    scripts:
      - acpi_call-module.sh
```

## acpi_call module isn't loaded after install :

Edit this file : `/etc/modules-load.d/acpi_call.conf` and add `acpi_call` to it.


## Special Thanks :

**Nix-Community for keeping acpi_call updated with newer kernels**
