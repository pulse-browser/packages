%define FirefoxVersion 87.0
%define GitBranch nightly

Name:           dot
Version:        0.1
Release:        1%{?dist}
Summary:        Dot Browser is a privacy-conscious web browser based on Firefox.

License:        MPL-2.0
URL:            https://github.com/dothq/browser-desktop
Source0:        https://github.com/dothq/browser-desktop/releases/latest/download/%{name}-%{FirefoxVersion}.source.tar.xz
Source1:        dot.desktop

BuildRequires:  zip
BuildRequires:  bzip2-devel
BuildRequires:  dbus-glib-devel
BuildRequires:  autoconf213
BuildRequires:  yasm
BuildRequires:  llvm
BuildRequires:  llvm-devel
BuildRequires:  clang
BuildRequires:  clang-libs
BuildRequires:  pipewire-devel
BuildRequires:  nodejs
BuildRequires:  nasm >= 1.13
BuildRequires:  libappstream-glib
BuildRequires:  pkgconfig(libpulse)
BuildRequires:  pkgconfig(pango)
BuildRequires:  pkgconfig(gtk+-3.0)
BuildRequires:  pkgconfig(gtk+-2.0)
BuildRequires:  libXt-devel     

ExclusiveArch:  x86_64

%description
Dot Browser is a privacy-conscious web browser based on Firefox.

%prep

# Verify certain build requirements (that aren't installed through the package manager) exist
if ! command -v rustc &> /dev/null
then
    echo -e "rust is not installed, please make sure to install it"
    %exit
fi
if ! command -v cbindgen &> /dev/null
then
    echo -e "cbindgen is not installed, please make sure to install it"
    %exit
fi

echo -e "WARNING You are compiling Dot from source! This will take up to an hour depending on your hardware."
echo -e "INFO You should install \`dot-bin\` if you do not want to compile from source."

%autosetup -n src


%build

export MACH_USE_SYSTEM_PYTHON=true
./mach build
./mach package

%install

DESTDIR=%{buildroot} make -c objdir install

# make applications dir
mkdir -p %{buildroot}{%{_libdir},%{_bindir},%{_datadir}/applications}

# add dot to OS
desktop-file-install --dir %{buildroot}%{_datadir}/applications %{SOURCE1}

%files
%license LICENSE

%changelog
* Fri Apr 16 2021 Trevor Thalacker <trevor@trevorthalacker.com>
- %prep works
* Thu Apr 15 2021 Trevor Thalacker <trevor@trevorthalacker.com>
- Initial Creation