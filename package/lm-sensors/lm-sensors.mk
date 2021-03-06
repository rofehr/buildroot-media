#############################################################
#
# lm-sensors
#
#############################################################
LM_SENSORS_VERSION = 3.3.2
LM_SENSORS_SOURCE = lm_sensors-$(LM_SENSORS_VERSION).tar.bz2
LM_SENSORS_SITE = http://dl.lm-sensors.org/lm-sensors/releases
LM_SENSORS_INSTALL_STAGING = YES
LM_SENSORS_BUILD_OPKG = YES
LM_SENSORS_SECTION = system
LM_SENSORS_DESCRIPTION = Hardware monitoring via the SMBus

LM_SENSORS_BINS_ = bin/sensors-conf-convert
LM_SENSORS_BINS_$(BR2_PACKAGE_LM_SENSORS_SENSORS) += bin/sensors
LM_SENSORS_BINS_$(BR2_PACKAGE_LM_SENSORS_FANCONTROL) += sbin/fancontrol
LM_SENSORS_BINS_$(BR2_PACKAGE_LM_SENSORS_ISADUMP) += sbin/isadump
LM_SENSORS_BINS_$(BR2_PACKAGE_LM_SENSORS_ISASET) += sbin/isaset
LM_SENSORS_BINS_$(BR2_PACKAGE_LM_SENSORS_SENSORS_DETECT) += sbin/sensors-detect

define LM_SENSORS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) MACHINE=$(KERNEL_ARCH) \
		PREFIX=/usr -C $(@D)
endef

define LM_SENSORS_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) PREFIX=/usr DESTDIR=$(STAGING_DIR) install
	rm -f $(addprefix $(STAGING_DIR)/usr/,$(LM_SENSORS_BINS_) $(LM_SENSORS_BINS_y))
endef

define LM_SENSORS_UNINSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) PREFIX=/usr DESTDIR=$(STAGING_DIR) uninstall
endef

define LM_SENSORS_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) PREFIX=/usr DESTDIR=$(TARGET_DIR) install
	rm -f $(addprefix $(TARGET_DIR)/usr/,$(LM_SENSORS_BINS_))
endef

define LM_SENSORS_UNINSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) PREFIX=/usr DESTDIR=$(TARGET_DIR) uninstall
endef

define LM_SENSORS_BUILD_OPKG_CMDS
	$(MAKE) -C $(@D) PREFIX=/usr DESTDIR=$(BUILD_DIR_OPKG)/$(LM_SENSORS_BASE_NAME) install
	rm -f $(addprefix $(BUILD_DIR_OPKG)/$(LM_SENSORS_BASE_NAME)/usr/,$(LM_SENSORS_BINS_))
endef

define LM_SENSORS_CLEAN_CMDS
	-$(MAKE) -C $(@D) clean
endef

$(eval $(call GENTARGETS,package,lm-sensors))
