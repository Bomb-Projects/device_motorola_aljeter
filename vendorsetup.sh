# Dependencies
echo "cloning dependencies"
git clone -b lineage-22.2 https://github.com/LineageOS/android_hardware_motorola hardware/motorola
echo ""

# DtbTools
wget -c https://github.com/krasCGQ/scripts/raw/master/prebuilts/bin/dtbToolLineage -P out/host/linux-x86/bin && chmod +777 out/host/linux-x86/bin/dtbToolLineage
echo ""
