%define name backports-lzma
%define version {version}
%define unmangled_name backports.lzma
%define unmangled_version {version}
%define release 1

Summary: Backport of Python 3.3's 'lzma' module for XZ/LZMA compressed files.
Name: %{{name}}
Version: %{{version}}
Release: %{{release}}
Source0: %{{unmangled_name}}-%{{unmangled_version}}.tar.gz
License: 3-clause BSD License
Group: Development/Libraries
BuildRoot: %{{_tmppath}}/%{{unmangled_name}}-release-%{{version}}-%{{release}}-buildroot
Prefix: %{{_prefix}}
Vendor: Peter Cock <p.j.a.cock@googlemail.com>
Url: https://github.com/peterjc/backports.lzma
BuildRequires: gcc, python2-setuptools, python2-devel, xz-devel

%description
Backport of Python 3.3's 'lzma' module for XZ/LZMA
compressed files.

%package -n python2-%{{name}}
Obsoletes: python-backports-lzma <= %{{version}}
Provides: python-backports-lzma = %{{version}}
Summary: Backport of Python 3.3's 'lzma' module for XZ/LZMA compressed files.
Requires: python2-backports

%description -n python2-%{{name}}
Backport of Python 3.3's 'lzma' module for XZ/LZMA
compressed files.

%prep
%autosetup -n %{{unmangled_name}}-%{{unmangled_version}}

%build
env CFLAGS="$RPM_OPT_FLAGS" %py2_build

%install
%py2_install
rm -f %{{buildroot}}/%{{_libdir}}/python2*/site-packages/backports/__init__.py*
rm -rf %{{buildroot}}/usr/share/doc/%{{name}}/

%clean
rm -rf %{{buildroot}}

%files -n python2-%{{name}}
%license LICENSE
%{{_libdir}}/python2*/site-packages/backports/lzma
%{{_libdir}}/python2*/site-packages/backports.lzma*.egg-info
%exclude %{{_bindir}}/*
%exclude %{{_libdir}}/python2*/site-packages/backports/*.pyc
%exclude %{{_libdir}}/python2*/site-packages/backports/*.pyo

%changelog
* {date_time} log2timeline development team <log2timeline-dev@googlegroups.com> {version}-1
- Auto-generated
