ifndef TARGET_KERNEL_USE
TARGET_KERNEL_USE := 5.10
endif
DB845C_KERNEL_DIR ?= device/linaro/dragonboard-kernel/android-$(TARGET_KERNEL_USE)

# Inherit the full_base and device configurations
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, device/linaro/dragonboard/db845c/device.mk)
$(call inherit-product, device/linaro/dragonboard/device-common.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Product overrides
PRODUCT_NAME := db845c
PRODUCT_DEVICE := db845c
PRODUCT_BRAND := Android

ifndef DB845C_USES_GKI
DB845C_USES_GKI := true
endif

ifeq ($(DB845C_USES_GKI), true)
  DB845C_MODS := $(wildcard $(DB845C_KERNEL_DIR)/*.ko)
  ifneq ($(DB845C_MODS),)
    VENDOR_KERN_MODS := %/qcom_q6v5_adsp.ko %/qcom_q6v5_mss.ko %/qcom_q6v5_pas.ko
    BOARD_VENDOR_KERNEL_MODULES := $(filter $(VENDOR_KERN_MODS),$(DB845C_MODS))
    BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(filter-out $(VENDOR_KERN_MODS),$(DB845C_MODS))
  endif
endif
