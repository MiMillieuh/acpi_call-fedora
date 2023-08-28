#!/bin/bash

ARCH=$(rpm -E '%_arch')
KERNEL=$(rpm -q kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')
RELEASE=$(rpm -E '%fedora')

git clone https://github.com/nix-community/acpi_call.git /tmp/acpi_call

cd /tmp/acpi_call

make -C /usr/src/kernels/${KERNEL} M=$(pwd) modules

if [ $? -ne 0 ]; then
    echo "Erreur lors de la compilation du module acpi_call."
    exit 1
fi

mkdir -p /usr/lib/modules/${KERNEL}/extra/acpi_call/
mv acpi_call.ko /usr/lib/modules/${KERNEL}/extra/acpi_call/


depmod -a ${KERNEL}

echo "Le module acpi_call a été compilé et déplacé avec succès pour le noyau ${KERNEL}."
