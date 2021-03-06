PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/invictrix/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/invictrix/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/invictrix/prebuilt/common/bin/50-invictrix.sh:system/addon.d/50-invictrix.sh \
    vendor/invictrix/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/invictrix/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/invictrix/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Invictrix-specific init file
PRODUCT_COPY_FILES += \
    vendor/invictrix/prebuilt/common/etc/init.local.rc:system/etc/init/init.invictrix.rc

# Copy LatinIME for gesture typing
PRODUCT_COPY_FILES += \
    vendor/invictrix/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/invictrix/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/invictrix/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/invictrix/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/invictrix/prebuilt/common/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Invictrix-specific startup services
PRODUCT_COPY_FILES += \
    vendor/invictrix/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/invictrix/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/invictrix/prebuilt/common/bin/sysinit:system/bin/sysinit

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    LockClock \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# Extra Optional packages
PRODUCT_PACKAGES += \
    Calculator \
    LatinIME \
    BluetoothExt


# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g


PRODUCT_PACKAGES += \
    charger_res_images

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGES += \
    AndroidDarkThemeOverlay \
    SettingsDarkThemeOverlay

# DU Utils Library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# Fonts
PRODUCT_PACKAGES += \
    DU-Fonts

# Overlays
PRODUCT_PACKAGES += \
    AmberAccent \
    BlackAccent \
    BlueAccent \
    BlueGreyAccent \
    BrownAccent \
    CyanAccent \
    DeepOrangeAccent \
    DeepPurpleAccent \
    DuiDark \
    GBoardDark \
    GreenAccent \
    GreyAccent \
    IndigoAccent \
    LightBlueAccent \
    LightGreenAccent \
    LimeAccent \
    OrangeAccent \
    PinkAccent \
    PurpleAccent \
    RedAccent \
    SettingsDark \
    SystemDark \
    TealAccent \
    YellowAccent \
    WhiteAccent

# Overlays
PRODUCT_PACKAGES += \
    DuiDark \
    GBoardDark \
    SettingsDark \
    SystemDark

PRODUCT_PACKAGE_OVERLAYS += vendor/invictrix/overlay/common

# Versioning System
# Invictrix first version.
PRODUCT_VERSION_MAJOR = 8
PRODUCT_VERSION_MINOR = 1.0
PRODUCT_VERSION_MAINTENANCE = 1.0
INVICTRIX_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
ifdef INVICTRIX_BUILD_EXTRA
    INVICTRIX_POSTFIX := -$(INVICTRIX_BUILD_EXTRA)
endif

ifndef INVICTRIX_BUILD_TYPE
    INVICTRIX_BUILD_TYPE := UNOFFICIAL
endif

ROM_FINGERPRINT := Invictrix/$(PLATFORM_VERSION)/$(INVICTRIX_BUILD)/$(shell date +%Y%m%d.%H:%M)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.invictrix.fingerprint=$(ROM_FINGERPRINT)

# Set all versions
INVICTRIX_VERSION := Invictrix-$(INVICTRIX_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(INVICTRIX_BUILD_TYPE)$(INVICTRIX_POSTFIX)
INVICTRIX_BUILD_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(PRODUCT_VERSION_MAINTENANCE)
INVICTRIX_MOD_VERSION := Invictrix-$(INVICTRIX_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(INVICTRIX_BUILD_TYPE)$(INVICTRIX_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    invictrix.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.invictrix.version=$(INVICTRIX_VERSION) \
    ro.invictrix.maintainer=$(INVICTRIX_MAINTAINER) \
    ro.invictrix.build.version=$(INVICTRIX_BUILD_VERSION) \
    ro.modversion=$(INVICTRIX_MOD_VERSION) \
    ro.invictrix.buildtype=$(INVICTRIX_BUILD_TYPE)

# Google sounds
include vendor/invictrix/google/GoogleAudio.mk

EXTENDED_POST_PROCESS_PROPS := vendor/invictrix/tools/invictrix_process_props.py

# Boot Animation
PRODUCT_PACKAGES += \
    bootanimation.zip \
    Updater \
    xdelta3

# Sign builds if building an official or weekly build
ifeq ($(filter-out Official Weekly,$(INVICTRIX_BUILD_TYPE)),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := ../.keys/releasekey
endif

# Set custom volume steps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30
