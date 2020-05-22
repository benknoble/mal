.POSIX:
SHELL = /bin/sh
.SUFFIXES:

RM = rm -f

BINS = \
       step0_repl \
       step1_read_print \
       step2_eval \
       step3_env \
       step4_if_fn_do \
       step5_tco \
       step6_file \
       step7_quote \
       step8_macros \
       step9_try \
       stepA_mal

CM = mal.cm
SOURCE = *.sml

BUILD = ml-build

all: $(BINS)

# ml-build automatically appends .$(ARCH)-$(OPSYS) to heap images, so we put
# them in a tmp file and then move it. If there were more than one, this could
# cause problems, but we *try* to match the heap image name as closely as
# possible.
$(BINS): $(CM) $(SOURCE)
	$(BUILD) $(BUILDFLAGS) $(CM) Main.$@ $@.tmp
	mv -- $@.tmp.*-* $@

clean:
	-$(RM) $(BINS)

distclean: clean
	-$(RM) -r .cm
