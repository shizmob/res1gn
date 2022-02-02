MKSQUASHFS = mksquashfs
SQUASHFLAGS = -all-root -le
RES1GN := res1gn/sbin/init res1gn/sbin/res1gn

.PHONY: all
all: res1gn.squashfs res1gn.dir
res1gn.squashfs: $(RES1GN)
res1gn.dir: $(RESIGN)


%.squashfs: %/
	@echo "ensuring mksquashfs is 3.x..."
	@$(MKSQUASHFS) -version 2>&- | grep -q 'version 3'
	$(MKSQUASHFS) $< $@ $(SQUASHFLAGS) -noappend

%.dir: %/
	cp -R $< $@

.PHONY: clean
clean:
	rm -rf *.squashfs *.dir
