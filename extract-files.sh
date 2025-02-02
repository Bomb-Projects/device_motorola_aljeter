#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=aljeter
VENDOR=motorola

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

function blob_fixup() {
    case "${1}" in
        system_ext/lib64/lib-imsvideocodec.so)
            "${PATCHELF}" --add-needed "libgui_shim.so" "${2}"
	    ;;

         vendor/lib/libmot_gpu_mapper.so)
            ${PATCHELF_0_17_2} --add-needed "libui_shim.so" "${2}"
            ;;

         vendor/lib/libmmcamera_vstab_module.so|vendor/lib/libjscore.so|vendor/lib/libmot_gpu_mapper.so)
            sed -i 's|libgui.so|libgui_shim_vendor.so|g' "${2}"
            ;;

        vendor/lib/libmmcamera2_pproc_modules.so)
            sed -i "s/ro.product.manufacturer/ro.product.nopefacturer/" "${2}"
            ;;

        vendor/lib/sensors.ssc.so|vendor/lib64/sensors.ssc.so)
            "${PATCHELF}" --replace-needed libutils.so libutils-v32.so "${2}"
            ;;

        vendor/lib/libSonyDualPDLibrary.so|vendor/lib/libSonyDualPDParam.so|vendor/lib/libarcsoft_beautyshot.so|vendor/lib/libfamily_photo.so|vendor/lib/libmmcamera_hdr_gb_lib.so|vendor/lib/libmorpho_image_stabilizer4.so)
            ${PATCHELF_0_17_2} --replace-needed libstdc++.so libstdc++_vendor.so "${2}"
            ;;
    esac
}

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
