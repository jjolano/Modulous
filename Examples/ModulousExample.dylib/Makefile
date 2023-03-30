ARCHS ?= armv7 armv7s arm64 arm64e
TARGET ?= iphone:clang:14.5:8.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ModulousExample

ModulousExample_FILES = Tweak.x
ModulousExample_CFLAGS = -fobjc-arc
ModulousExample_CFLAGS += -Ivendor/Modulous.framework/Headers
ModulousExample_LDFLAGS = -rpath /Library/Frameworks -rpath /var/jb/Library/Frameworks -rpath /usr/lib -rpath /var/jb/usr/lib
ModulousExample_LDFLAGS += -Fvendor
ModulousExample_EXTRA_FRAMEWORKS = Modulous

include $(THEOS_MAKE_PATH)/tweak.mk
