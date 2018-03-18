include vendor/invictrix/config/version.mk

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Fixes: terminate called after throwing an instance of 'std::out_of_range' what(): basic_string::erase
# error with prop override
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# general properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    persist.sys.root_access=1 \
    ro.opa.eligible_device=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/invictrix/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/invictrix/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/invictrix/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/invictrix/prebuilt/bin/blacklist:system/addon.d/blacklist

# init.d support
PRODUCT_COPY_FILES += \
    vendor/invictrix/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/invictrix/prebuilt/bin/sysinit:system/bin/sysinit \
    vendor/invictrix/prebuilt/etc/init.invictrix.rc:root/init.invictrix.rc

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Additional packages
-include vendor/invictrix/config/packages.mk

# Versioning
-include vendor/invictrix/config/version.mk

# SELinux Policy
-include vendor/invictrix/sepolicy/sepolicy.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/invictrix/overlay/common

# Squisher Location
SQUISHER_SCRIPT := vendor/invictrix/tools/squisher

# Include SDCLANG definitions if it is requested and available
ifeq ($(HOST_OS),linux)
    ifneq ($(wildcard vendor/qcom/sdclang-4.0/),)
        include vendor/invictrix/sdclang/sdclang.mk
    endif
endif

# Boot Animation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Updater packages
PRODUCT_PACKAGES += \
    Updater \
    xdelta3

# Theme Service
PRODUCT_PACKAGES += \
    ThemeClient
