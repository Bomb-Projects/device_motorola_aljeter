# Dependencies
echo "cloning dependencies"
git clone -b lineage-18.1 https://github.com/LineageOS/android_external_sony_boringssl-compat external/sony/boringssl-compat
git clone -b lineage-20 https://github.com/LineageOS/android_system_qcom system/qcom
git clone -b lineage-20 https://github.com/LineageOS/android_hardware_motorola hardware/motorola
echo ""

# DtbTools
wget -c https://github.com/krasCGQ/scripts/raw/master/prebuilts/bin/dtbToolLineage -P out/host/linux-x86/bin && chmod +777 out/host/linux-x86/bin/dtbToolLineage
echo ""
