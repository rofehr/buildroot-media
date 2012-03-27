################################################################################
#
# xlib_libXxf86dga -- X.Org Xxf86dga library
#
################################################################################

XLIB_LIBXXF86DGA_VERSION = 1.1.1
XLIB_LIBXXF86DGA_SOURCE = libXxf86dga-$(XLIB_LIBXXF86DGA_VERSION).tar.bz2
XLIB_LIBXXF86DGA_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXXF86DGA_AUTORECONF = NO
XLIB_LIBXXF86DGA_INSTALL_STAGING = YES
XLIB_LIBXXF86DGA_DEPENDENCIES = xlib_libX11 xlib_libXext xproto_xf86dgaproto xproto_xproto
XLIB_LIBXXF86DGA_CONF_OPT = --disable-malloc0returnsnull

$(eval $(call AUTOTARGETS,package/x11r7,xlib_libXxf86dga))
