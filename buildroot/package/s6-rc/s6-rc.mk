################################################################################
#
# s6-rc
#
################################################################################

S6_RC_VERSION = v0.0.1.0
S6_RC_SITE = git://git.skarnet.org/s6-rc.git
S6_RC_LICENSE = ISC
S6_RC_LICENSE_FILES = COPYING
S6_RC_INSTALL_STAGING = YES
S6_RC_DEPENDENCIES = s6

S6_RC_CONFIGURE_OPTS = \
	--prefix=/usr \
	--with-sysdeps=$(STAGING_DIR)/usr/lib/skalibs/sysdeps \
	--with-include=$(STAGING_DIR)/usr/include \
	--with-dynlib=$(STAGING_DIR)/usr/lib \
	--with-lib=$(STAGING_DIR)/usr/lib/execline \
	--with-lib=$(STAGING_DIR)/usr/lib/s6 \
	--with-lib=$(STAGING_DIR)/usr/lib/skalibs

ifeq ($(BR2_STATIC_LIBS),y)
S6_RC_CONFIGURE_OPTS +=  --enable-static --disable-shared
else
S6_RC_CONFIGURE_OPTS +=  --disable-static --enable-shared --disable-allstatic
endif

define S6_RC_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) ./configure $(S6_RC_CONFIGURE_OPTS))
endef

define S6_RC_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D)
endef

define S6_RC_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

define S6_RC_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) DESTDIR=$(STAGING_DIR) install
endef

HOST_S6_RC_DEPENDENCIES = host-s6

HOST_S6_RC_CONFIGURE_OPTS = \
	--prefix=/usr \
	--with-sysdeps=$(HOST_DIR)/usr/lib/skalibs/sysdeps \
	--with-include=$(HOST_DIR)/usr/include \
	--with-dynlib=$(HOST_DIR)/usr/lib \
	--disable-static \
	--enable-shared \
	--disable-allstatic

define HOST_S6_RC_CONFIGURE_CMDS
	(cd $(@D); $(HOST_CONFIGURE_OPTS) ./configure $(HOST_S6_RC_CONFIGURE_OPTS))
endef

define HOST_S6_RC_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(HOST_DIR)
endef

define HOST_S6_RC_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(HOST_DIR) \
		install-dynlib \
		install-bin
	rm -f $(HOST_DIR)/usr/bin/s6-rc-dryrun
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
