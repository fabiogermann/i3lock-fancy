#
# i3lock-fancy deveelopment tasks
#

SPECFILE := i3lock-fancy.spec

WORKDIR := $(CURDIR)
SPECDIR ?= $(WORKDIR)
SRCRPMDIR ?= $(WORKDIR)/../srpm
BUILDDIR ?= $(WORKDIR)
RPMDIR ?= $(WORKDIR)/../rpm
SOURCEDIR := $(WORKDIR)

RPM_DEFINES := --define "_sourcedir $(SOURCEDIR)" \
               --define "_specdir $(SPECDIR)" \
               --define "_builddir $(BUILDDIR)" \
               --define "_srcrpmdir $(SRCRPMDIR)" \
               --define "_rpmdir $(RPMDIR)"

DIST_DOM0 ?= fc25

BUILDDIR  ?= build

PRGM = i3lock-fancy
PREFIX ?= /usr
SHRDIR ?= $(PREFIX)/share
BINDIR ?= $(PREFIX)/bin

rpms: rpms-dom0

rpms-vm:

rpms-dom0:
	rpmbuild $(RPM_DEFINES) -bb $(SPECFILE)

install:
	@install -Dm755 i3lock-fancy          -t $(DESTDIR)$(BINDIR)
	@install -Dm644 icons/*               -t $(DESTDIR)$(SHRDIR)/$(PRGM)/icons
	@install -Dm644 doc/i3lock-fancy.1    -t $(DESTDIR)$(SHRDIR)/man/man1
	@install -Dm644 LICENSE               -t $(DESTDIR)$(SHRDIR)/licenses/$(PRGM)

# vim:ts=2 sw=2 noet nolist
