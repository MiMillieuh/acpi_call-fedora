# acpi_call-fedora
The glorious acpi_call Kernel module for FEDORA !!!!!!!

Compiled with https://github.com/nix-community/acpi_call

## Install : 

Download the rpm from here : [release](https://github.com/MiMillieuh/acpi_call-fedora/releases/)

`sudo rpm -i acpi_call-*.rpm`

modprobe it if not loaded : 

`sudo modprobe acpi_call`

### UblueOS : 

if you want to install it to your custom UblueOS you can do it in two ways : 

**Hosted (simplest way) :**

if you want to use this repo as host you can download acpi_call-modification-hosted.zip in [release](https://github.com/MiMillieuh/acpi_call-fedora/releases/) extract it and add it directly to your UblueOS repo

**Self-Hosted (still simple but harder than hosted) :**

if you want to self-host it you can download acpi_call-modification-self-hosted.zip in [release](https://github.com/MiMillieuh/acpi_call-fedora/releases/) extract it and modify in `scripts/post/acpi_call-module.sh` at the wget line the url with your repo and username. it should look like this : 

`wget https://github.com/MiMillieuh/Ublue-MiMiOS/raw/live/modules/acpi_call.ko`


## Special Thanks :

**Nix-Community for keeping acpi_call updated with newer kernels**
