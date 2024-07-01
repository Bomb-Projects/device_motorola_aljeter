# Dependencies
echo "cloning dependencies"
git clone -b lineage-18.1 https://github.com/LineageOS/android_external_sony_boringssl-compat external/sony/boringssl-compat
git clone -b lineage-18.1 https://github.com/LineageOS/android_system_qcom system/qcom
git clone -b lineage-18.1 https://github.com/LineageOS/android_hardware_motorola hardware/motorola
echo ""

# Kernel
echo "Cloning clang"
git clone --depth=1 -b 14 https://gitlab.com/ThankYouMario/android_prebuilts_clang-standalone prebuilts/clang/host/linux-x86/clang-r450784e
echo ""

# DtbTools
git clone https://github.com/LineageOS/android_system_tools_dtbtool system/tools/dtbtool
echo ""
