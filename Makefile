# -*- makefile-gmake -*-

# Available rules:
#  make help

# You can redefine the following rules to extend the build system:
#
# all::
# 	@# Commands run after "make" or "make all"
#
# clean::
# 	@# Commands run after "make clean"


# Re-define any of the following variables to use different programs

# Additional arguments passed to latexbuild
LATEXBUILD_ARGS ?=

# Default to system installation
LATEXRUN ?=
# Additional arguments passed to latexrun
LATEXRUN_ARGS ?= -Wall

# Default to system installation
LATEXDEPS ?=
# Additional arguments passed to latexdeps
LATEXDEPS_ARGS ?=

# Default to system installation (if available, otherwise ignore)
LACHECK ?=

# Default to system installation
GIT ?=


######################################################################
### Internal code
######################################################################

######################################################################
### Generic rules

all:: force
	@# pass

.PHONY: force
force:

######################################################################
### build

%.pdf: %.tex
%.pdf: LATEXBUILD = $(strip $(foreach mf,$(MAKEFILE_LIST),$(wildcard $(dir $(mf))/latexbuild)))
ifneq ($(LATEXRUN),)
%.pdf: ARGS += --latexrun="$(LATEXRUN)"
endif
%.pdf: ARGS += $(foreach arg,$(LATEXRUN_ARGS),--latexrun-args="$(arg)")
ifneq ($(LATEXDEPS),)
%.pdf: ARGS += --latexdeps="$(LATEXDEPS)"
endif
%.pdf: ARGS += $(foreach arg,$(LATEXDEPS_ARGS),--latexdeps-args="$(arg)")
ifneq ($(GIT),)
%.pdf: ARGS += --git="$(GIT)"
endif
%.pdf: force
	TEXINPUTS=$(TEXINPUTS): "$(LATEXBUILD)" "$*.tex" $(LATEXBUILD_ARGS) $(ARGS)


######################################################################
### Miscellaneous rules

help:: force
	@echo "latexbuild targets:"
	@echo "   <name>.pdf : generate a single pdf document from '<name>.tex'"
	@echo "   clean      : clean intermediate files"
	@echo ""

clean:: force
	rm -Rf latex.out
