################################################################################
#
# xproto_scrnsaverproto -- X.Org ScrnSaver protocol headers
#
################################################################################

XPROTO_SCRNSAVERPROTO_VERSION = 1.2.2
XPROTO_SCRNSAVERPROTO_SOURCE = scrnsaverproto-$(XPROTO_SCRNSAVERPROTO_VERSION).tar.bz2
XPROTO_SCRNSAVERPROTO_SITE = http://xorg.freedesktop.org/releases/individual/proto
XPROTO_SCRNSAVERPROTO_AUTORECONF = NO
XPROTO_SCRNSAVERPROTO_INSTALL_STAGING = YES
XPROTO_SCRNSAVERPROTO_INSTALL_TARGET = NO
XPROTO_SCRNSAVERPROTO_DEPENDENCIES = xutil_util-macros

$(eval $(call AUTOTARGETS,package/x11r7,xproto_scrnsaverproto))
