
Name:           acpi_call
Version:        1.2.2
Release:        1
Summary:        A kernel module to call ACPI methods

License:        GPL
URL:            https://github.com/nix-community/acpi_call
Source0:        acpi_call-master.zip

BuildRequires:  dkms
Requires:       akmods
Requires(post): dkms
Requires(preun): dkms

%define debug_package %{nil}

%description
ACPI_CALL est un module du noyau Linux qui permet de faire des appels à des méthodes ACPI directement depuis l'espace utilisateur. Ceci est particulièrement utile pour des scripts ou autres programmes qui souhaitent obtenir ou définir des informations ACPI.

%prep
%setup -q -n acpi_call-master

%build
# La phase de construction est gérée par DKMS

%install
mkdir -p %{buildroot}/usr/src/acpi_call-%{version}
cp -a * %{buildroot}/usr/src/acpi_call-%{version}

%post
dkms add -m acpi_call -v %{version}
dkms build -m acpi_call -v %{version}
dkms install -m acpi_call -v %{version}

%preun
dkms remove -m acpi_call -v %{version} --all

%files
/usr/src/acpi_call-%{version}

%changelog
* Mon Aug 21 2023 MiMillie mimillie290@gmail.com> - 1.1.0-1
- Initial RPM release for fedora akmod
