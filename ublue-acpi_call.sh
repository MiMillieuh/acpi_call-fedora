#!/bin/bash

ln -sf /usr/bin/ld.bfd /etc/alternatives/ld && ln -sf /etc/alternatives/ld /usr/bin/ld

# Récupération des variables cibles
ARCH=$(rpm -E '%_arch')
KERNEL=$(rpm -q kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')
RELEASE=$(rpm -E '%fedora')

echo "Kernel module folder :"
ls /usr/lib/modules/

echo "Kernel SRC folder :"
ls /usr/src/kernels/

echo "LD path :"
find /usr -name ld
which ld

# Cloner le dépôt
git clone https://github.com/nix-community/acpi_call.git /tmp/acpi_call

# Aller dans le répertoire cloné
cd /tmp/acpi_call

# Compiler le module pour le noyau cible
make -C /usr/src/kernels/${KERNEL} M=$(pwd) modules

# Vérifier si la compilation a réussi
if [ $? -ne 0 ]; then
    echo "Erreur lors de la compilation du module acpi_call."
    exit 1
fi

# Déplacer le module au bon emplacement
mkdir -p /usr/lib/modules/${KERNEL}/extra/acpi_call/
mv acpi_call.ko /usr/lib/modules/${KERNEL}/extra/acpi_call/


# Mettre à jour les dépendances du module pour le noyau spécifié
depmod -a ${KERNEL}

# Afficher un message de confirmation
echo "Le module acpi_call a été compilé et déplacé avec succès pour le noyau ${KERNEL}."
