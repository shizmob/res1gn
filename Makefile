MKSQUASHFS = mksquashfs
MKSQUASHFS3 = $(MKSQUASHFS)
MKSQUASHFS4 = $(MKSQUASHFS)
SQUASHFLAGS = -all-root
SQUASH3FLAGS = -le
SQUASH4FLAGS = -root-mode 755
RES1GN := res1gn/sbin/init res1gn/sbin/res1gn

.PHONY: all
all: res1gn.3.squashfs res1gn.4.squashfs res1gn.dir
res1gn.3.squashfs: $(RES1GN)
res1gn.4.squashfs: $(RES1GN)
res1gn.dir: $(RESIGN)


%.3.squashfs: %/
	@echo "ensuring $(MKSQUASHFS3) is 3.x..."
	@$(MKSQUASHFS3) -version 2>&- | grep -q 'version 3'
	$(MKSQUASHFS3) $< $@ $(SQUASHFLAGS) $(SQUASH3FLAGS) -noappend

%.4.squashfs: %/
	@echo "ensuring $(MKSQUASHFS4) is 4.x..."
	@$(MKSQUASHFS4) -version 2>&- | grep -q 'version 4'
	$(MKSQUASHFS4) $< $@ $(SQUASHFLAGS) $(SQUASH4FLAGS) -noappend

%.dir: %/
	cp -R $< $@

.PHONY: clean
clean:
	rm -rf *.squashfs *.dir
