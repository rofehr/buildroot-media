#############################################################
#
# sqlite
#
#############################################################

SQLITE_VERSION = 3070603
SQLITE_SOURCE = sqlite-autoconf-$(SQLITE_VERSION).tar.gz
SQLITE_SITE = http://www.sqlite.org
SQLITE_INSTALL_STAGING = YES
SQLITE_BUILD_OPKG = YES

SQLITE_SECTION = database
SQLITE_PRIORITY = optional
SQLITE_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
SQLITE_DESCRIPTION = An Embeddable SQL Database Engine

ifneq ($(BR2_LARGEFILE),y)
# the sqlite configure script fails to define SQLITE_DISABLE_LFS when
# --disable-largefile is passed, breaking the build. Work around it by
# simply adding it to CFLAGS for configure instead
SQLITE_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -DSQLITE_DISABLE_LFS"
endif

SQLITE_CONF_OPT =	--enable-tempstore=yes \
			--enable-threadsafe \
			--enable-releasemode \
			--disable-tcl \
			--localstatedir=/var \
			--enable-dynamic-extensions

ifeq ($(BR2_PACKAGE_SQLITE_READLINE),y)
SQLITE_OPKG_DEPENDENCIES = ncurses,readline
SQLITE_DEPENDENCIES += ncurses readline
SQLITE_CONF_OPT += --with-readline-inc="-I$(STAGING_DIR)/usr/include"
else
SQLITE_CONF_OPT += --disable-readline
endif

define SQLITE_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/bin/sqlite3
	rm -f $(TARGET_DIR)/usr/lib/libsqlite3*
endef

define SQLITE_UNINSTALL_STAGING_CMDS
	rm -f $(STAGING_DIR)/usr/bin/sqlite3
	rm -f $(STAGING_DIR)/usr/lib/libsqlite3*
	rm -f $(STAGING_DIR)/usr/lib/pkgconfig/sqlite3.pc
	rm -f $(STAGING_DIR)/usr/include/sqlite3*.h
endef

$(eval $(call AUTOTARGETS,package,sqlite))
