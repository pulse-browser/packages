%define FirefoxVersion 87.0
%define GitBranch nightly
%define ORANGE \033[1;33m
%define BLUE \033[1;34m
%define NC \033[0m

Name:           dot
Version:        0.1
Release:        1%{?dist}
Summary:        Dot Browser is a privacy-conscious web browser based on Firefox.

License:        MPL-2.0
URL:            https://github.com/dothq/browser-desktop
Source0:        https://github.com/dothq/browser-desktop/archive/refs/heads/browser-desktop-%{GitBranch}.tar.gz
Source1:        https://archive.mozilla.org/pub/firefox/releases/%{FirefoxVersion}/source/firefox-%{FirefoxVersion}.source.tar.xz

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

Requires:       

BuildArch:      x86_64

%description
Dot Browser is a privacy-conscious web browser based on Firefox.

%prep
%autosetup -n browser-desktop-%{GitBranch}
%autosetup -b 1 -n firefox-%{FirefoxVersion}

cd ..

echo -e "%{ORANGE}WARNING%{NC} You are compiling Dot from source! This will take up to an hour depending on your hardware."
echo -e "%{BLUE}INFO%{NC} You should install \`dot-bin\` if you do not want to compile from source."

git init
git config core.autocrlf false
git checkout --orphan ff
git add . -v > /dev/null
git commit -am "Firefox" > /dev/null
git checkout -b dot
    
mv ../firefox-%{FirefoxVersion} src


%build

export MACH_USE_SYSTEM_PYTHON=true
./melon import --minimal
./melon build
./melon package


%install
rm -rf $RPM_BUILD_ROOT
%make_install

%files
%license LICENSE

%changelog
* Fri Apr 16 2021 Trevor Thalacker <trevor@trevorthalacker.com>
- %prep works
* Thu Apr 15 2021 Trevor Thalacker <trevor@trevorthalacker.com>
- Initial Creation