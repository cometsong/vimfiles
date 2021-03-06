#------------------------------------------------------------------------------#
#                        Makefile for Cometsong vimfiles!                      #
#------------------------------------------------------------------------------#

# Vars for customization
SRCDIR := $(PWD)
DESTDIR := $(HOME)

all: normals gits
normals: vims bins
gits: submodules

VIMFILES=vimrc gvimrc vim
BINFILES=$(shell ls -1 $(SRCDIR)/bin)


# Usage: links,file-dir-names,filepath,linkpath,dot
#	1=file-dir-names, 2=srcpath, 3=destpath, 4=dot-or-not
define links
	$(foreach FILE,$(1),\
		if [ -e $(3)/$(4)$(FILE) ]; then \
			rm -rf $(3)/$(4)$(FILE); \
		fi; \
		ln -sf $(2)/$(FILE) $(3)/$(4)$(FILE); \
		echo "    Link to $(FILE) .... $(3)/$(4)$(FILE)"; \
	)
endef

vims:
	@echo Link all vimfiles
	@$(call links,$(VIMFILES),$(SRCDIR),$(DESTDIR),.)

bins:
	@echo 'Link all files in bin (e.g. 'gvims')'
	@if [ ! -d $(DESTDIR)/bin ]; then mkdir -p $(DESTDIR)/bin; fi
	@$(call links,$(BINFILES),$(SRCDIR)/bin,$(DESTDIR)/bin)

submodules:
	@echo Git submodule init and update
	@git submodule update --init --recursive

