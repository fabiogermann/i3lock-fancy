Name: i3lock-fancy
Version: 0.1
Release: 1%{?dist}
Summary: Wrapper of improved improved screen locker - "the ricing fork of i3lock"

License: BSD
URL: https://github.com/fabiogermann/i3lock-fancy

Provides:  i3lock-fancy

%description
Improvement wrapper of i3lock is a simple screen locker like slock. After starting it, you will see a white screen (you can configure the color/an image). You can return to your screen by entering your password.

%prep
# none

%build
# none

%install
%make_install

%check

%files
%{_bindir}/i3lock-fancy
%{_mandir}/man1/i3lock-fancy.*
%{_datadir}/%{name}/icons/*

%license LICENSE
