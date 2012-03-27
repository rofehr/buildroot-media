#############################################################
#
# expat
#
#############################################################

EXPAT_VERSION = 2.0.1
EXPAT_SOURCE = expat-$(EXPAT_VERSION).tar.gz
EXPAT_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/expat
EXPAT_INSTALL_STAGING = YES
EXPAT_INSTALL_TARGET = YES

EXPAT_BUILD_OPKG = YES
EXPAT_SECTION = text
EXPAT_PRIORITY = optional
EXPAT_MAINTAINER = Vladimir Ivakin vladimir_iva@pisem.net
EXPAT_DESCRIPTION = XML parser library
EXPAT_OPKG_DEPENDENCIES = 

EXPAT_INSTALL_STAGING_OPT = DESTDIR=$(STAGING_DIR) installlib
EXPAT_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) installlib
EXPAT_BUILD_OPKG_OPT = DESTDIR=$(BUILD_DIR_OPKG)/expat-$(EXPAT_VERSION) installlib

EXPAT_DEPENDENCIES = host-pkg-config

$(eval $(call AUTOTARGETS,package,expat))
$(eval $(call AUTOTARGETS,package,expat,host))
