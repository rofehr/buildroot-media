#############################################################
#
# PCIUTILS
#
#############################################################

PCIUTILS_VERSION = 3.1.9
PCIUTILS_SITE = ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci

PCIUTILS_BUILD_OPKG = YES
PCIUTILS_OPKG_DEPENDENCIES = busybox

PCIUTILS_SECTION = system
PCIUTILS_DESCRIPTION = Linux PCI Utilities

ifeq ($(BR2_PACKAGE_ZLIB),y)
	PCIUTILS_ZLIB=yes
	PCIUTILS_DEPENDENCIES += zlib
	PCIUTILS_OPKG_DEPENDENCIES += ,zlib
else
	PCIUTILS_ZLIB=no
endif
PCIUTILS_DNS=no
PCIUTILS_SHARED=yes
PCIUTILS_IDSDIR=/usr/share

define PCIUTILS_CONFIGURE_CMDS
	$(SED) 's/wget --no-timestamping/wget/' $(PCIUTILS_DIR)/update-pciids.sh
	$(SED) 's/uname -s/echo Linux/' \
		-e 's/uname -r/echo $(LINUX_HEADERS_VERSION)/' \
		$(PCIUTILS_DIR)/lib/configure
	$(SED) 's/^STRIP/#STRIP/' $(PCIUTILS_DIR)/Makefile
endef

define PCIUTILS_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" \
		HOST="$(KERNEL_ARCH)-linux" \
		OPT="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		RANLIB=$(TARGET_RANLIB) \
		AR=$(TARGET_AR) \
		-C $(PCIUTILS_DIR) \
		SHARED=$(PCIUTILS_SHARED) \
		ZLIB=$(PCIUTILS_ZLIB) \
		DNS=$(PCIUTILS_DNS) \
		IDSDIR=$(PCIUTILS_IDSDIR) \
		PREFIX=/usr
endef

# Ditch install-lib if SHARED is an option in the future
define PCIUTILS_INSTALL_TARGET_CMDS
	$(MAKE) BUILDDIR=$(@D) -C $(@D) PREFIX=/usr \
		IDSDIR=$(PCIUTILS_IDSDIR) \
		DESTDIR=$(TARGET_DIR) \
		SHARED=$(PCIUTILS_SHARED) install
	$(MAKE) BUILDDIR=$(@D) -C $(@D) PREFIX=/usr \
		IDSDIR=$(PCIUTILS_IDSDIR) \
		DESTDIR=$(TARGET_DIR) \
		SHARED=$(PCIUTILS_SHARED) install-lib
endef

define PCIUTILS_BUILD_OPKG_CMDS
	$(MAKE) BUILDDIR=$(@D) -C $(@D) PREFIX=/usr \
		IDSDIR=$(PCIUTILS_IDSDIR) \
		DESTDIR=$(BUILD_DIR_OPKG)/pciutils-$(PCIUTILS_VERSION) \
		SHARED=$(PCIUTILS_SHARED) install
	$(MAKE) BUILDDIR=$(@D) -C $(@D) PREFIX=/usr \
		IDSDIR=$(PCIUTILS_IDSDIR) \
		DESTDIR=$(BUILD_DIR_OPKG)/pciutils-$(PCIUTILS_VERSION) \
		SHARED=$(PCIUTILS_SHARED) install-lib
	rm -f $(BUILD_DIR_OPKG)/pciutils-$(PCIUTILS_VERSION)/usr/sbin/{setpci,update-pciids}
endef

$(eval $(call GENTARGETS,package,pciutils))
