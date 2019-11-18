#
# i3lock-color deveelopment tasks
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
GENERATOR ?= $(shell for c in ninja make; do command -vp $$c; done | xargs basename | sed "s/ninja/Ninja/;s/make/Unix Makefiles/")

PRGM = i3lock-fancy
PREFIX ?= /usr
SHRDIR ?= $(PREFIX)/share
BINDIR ?= $(PREFIX)/bin

rpms: rpms-dom0

rpms-vm:

rpms-dom0:
	rpmbuild $(RPM_DEFINES) -bb $(SPECFILE)

all: configure build link

help:
	@echo "Available targets:"
	@awk -F':' '/^\w*:/ {print "  "$$1;}' Makefile

configure:
	@echo "\033[32;1m**\033[0m Configuring..."
	@mkdir -p $(BUILDDIR)
	@cd $(BUILDDIR) && cmake -G "$(GENERATOR)" ..

build:
	@echo "\033[32;1m**\033[0m Building..."
	@cmake --build $(BUILDDIR)

install:
	@install -Dm755 i3lock-fancy          -t $(DESTDIR)$(BINDIR)
	@install -Dm644 icons/*               -t $(DESTDIR)$(SHRDIR)/$(PRGM)/icons
	@install -Dm644 doc/i3lock-fancy.1    -t $(DESTDIR)$(SHRDIR)/man/man1
	@install -Dm644 LICENSE               -t $(DESTDIR)$(SHRDIR)/licenses/$(PRGM)

link:
	@echo "\033[32;1m**\033[0m Linking executable..."
	@if [ -x $(BUILDDIR)/bin/polybar ]; then ln -sfv $(BUILDDIR)/bin/polybar; fi
	@if [ -x $(BUILDDIR)/bin/polybar-msg ]; then ln -sfv $(BUILDDIR)/bin/polybar-msg; fi

clean:
	@echo "\033[32;1m**\033[0m Cleaning up..."
	@if [ -d $(BUILDDIR) ]; then rm -rf $(BUILDDIR); fi
	@if [ -L polybar ]; then rm -v polybar; fi
	@if [ -L polybar-msg ]; then rm -v polybar-msg; fi

.PHONY: configure build link clean help

# vim:ts=2 sw=2 noet nolist
