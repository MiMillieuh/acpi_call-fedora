Name:           akmod-acpi_call
Version:        1.2.2
Release:        1
Summary:        Akmod package for the acpi_call kernel module

License:        GPL
URL:            https://github.com/nix-community/acpi_call
Source0:        acpi_call-master.zip
BuildRequires:  akmods
BuildRequires:  kernel-devel
Requires(post): akmods
Requires(postun): akmods

%define debug_package %{nil}

%description
ACPI_CALL est un module du noyau Linux qui permet de faire des appels à des méthodes ACPI directement depuis l'espace utilisateur. Ceci est particulièrement utile pour des scripts ou autres programmes qui souhaitent obtenir ou définir des informations ACPI.

%prep
%setup -q -n acpi_call-master

%build
# Construction du module pour le noyau actuel
make -C /lib/modules/$(uname -r)/build M=$(pwd)

%install
# Installation du module dans le répertoire approprié pour akmods
install -D -m 644 acpi_call.ko %{buildroot}/usr/lib/modules/$(uname -r)/extra/acpi_call/acpi_call.ko

mkdir -p %{buildroot}/usr/src/akmods/
cp %{_sourcedir}/%{name}-%{version}.src.rpm %{buildroot}/usr/src/akmods/
echo %{name}-%{version}.src.rpm > %{buildroot}/usr/src/akmods/%{name}.latest

%post
/sbin/akmodsbuild %{_rpmfilename}

%postun
/sbin/akmodsbuild %{_rpmfilename}

%files
/usr/lib/modules/*/extra/acpi_call/acpi_call.ko
/usr/src/akmods/%{name}-%{version}.src.rpm
/usr/src/akmods/%{name}.latest
%changelog
* Mon Aug 21 2023 MiMillie mimillie290@gmail.com> - 1.1.0-1
- Initial RPM release for fedora akmod
