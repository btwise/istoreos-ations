#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改openwrt登陆地址,把下面的 10.0.0.1 修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.31.254/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.100.1/192.168.31.254/g' package/istoreos-files/Makefile
#sed -i '/local bridge=\$2/a\local protocol="static"' package/base-files/files/bin/config_generate
#sed -i "s/set network.\$1.proto='.*'/set network.\$1.proto='static'/" package/base-files/files/bin/config_generate
#sed -i 's/set network.\$1.proto='\''\$protocol'\''/set network.\$key.proto='\''static'\''/g' package/base-files/files/bin/config_generate
#sed -i 's/set network.\$1.auto='\''0'\''/set network.\$key.ipaddr='\''192.168.31.254'\''\nset network.\$key.netmask='\''255.255.255.0'\''\nset network.\$1.auto='\''0'\''/g' package/base-files/files/bin/config_generate
# 修改 子网掩码
#sed -i 's/255.255.255.0/255.255.0.0/g' package/base-files/files/bin/config_generate

#让编译后的镜像第一次启动时，如果检测到网卡只有一个，自动设置网卡IP地址为静态，而不是DHCP自动获取
# 使用sed命令将给定的脚本内容插入到rc.local文件中exit 0之前

# sed -i '/exit 0/i\
# if [ ! -f /etc/.firstboot_done ]; then\n\
#     if [ $(lspci | grep -i 'Ethernet controller' | wc -l) -eq 1 ]; then\n\
#         uci set network.lan.proto='static'\n\
#         network.lan.ip6assign='60'\n\
#         network.lan.ipaddr='192.168.31.253'\n\
#         network.lan.netmask='255.255.255.0'\n\
#         uci commit network\n\
#     fi\n\
#     touch /etc/.firstboot_done\n\
# fi' package/base-files/files/etc/rc.local

# 修改主机名字，把 iStore OS 修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i 's/OpenWrt/iStore OS/g' package/base-files/files/bin/config_generate

# ttyd 自动登录
 sed -i "s?/bin/login?/usr/libexec/login.sh?g" ${GITHUB_WORKSPACE}/openwrt/package/feeds/packages/ttyd/files/ttyd.config

# 修改 WiFi 名称
# sed -i 's/OpenWrt/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 默认打开 WiFi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# openclash
#svn export https://github.com/kenzok8/openwrt-packages/luci-app-openclash  package/luci-app-openclash
# svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-openclash  package/luci-app-openclash
# 加入OpenClash核心
chmod -R a+x $GITHUB_WORKSPACE/preset-clash-core.sh
# if [ "$1" = "rk33xx" ]; then
#     $GITHUB_WORKSPACE/preset-clash-core.sh arm64
# elif [ "$1" = "rk35xx" ]; then
#     $GITHUB_WORKSPACE/preset-clash-core.sh arm64
# elif [ "$1" = "x86" ]; then
#     $GITHUB_WORKSPACE/preset-clash-core.sh amd64
# fi
$GITHUB_WORKSPACE/preset-clash-core.sh amd64

# adguardhome
#svn export https://github.com/kenzok8/openwrt-packages/luci-app-adguardhome package/luci-app-adguardhome
#svn export https://github.com/kenzok8/openwrt-packages/adguardhome package/adguardhome
# svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome package/luci-app-adguardhome
# svn export https://github.com/kiddin9/openwrt-packages/trunk/adguardhome package/adguardhome

# mosdns
# svn export https://github.com/kenzok8/openwrt-packages/luci-app-mosdns package/luci-app-mosdns
# svn export https://github.com/kenzok8/openwrt-packages/trunk/mosdns package/mosdns
# svn export https://github.com/kenzok8/openwrt-packages/trunk/v2dat package/v2dat
# svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-mosdns package/luci-app-mosdns
# svn export https://github.com/kiddin9/openwrt-packages/trunk/mosdns package/mosdns
# svn export https://github.com/kiddin9/openwrt-packages/trunk/v2dat package/v2dat

#修改分区大小
sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=256/CONFIG_TARGET_ROOTFS_PARTSIZE=2048/g' .config

echo "
# 额外组件
CONFIG_GRUB_IMAGES=y
CONFIG_VMDK_IMAGES=y

# 关机
CONFIG_PACKAGE_luci-app-poweroff=y
#CONFIG_PACKAGE_luci-i18n-poweroff-zh-cn=y

# openclash
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_luci-i18n-openclash-zh-cn=y

# ddns-go
CONFIG_PACKAGE_luci-app-ddns-go=y

#netspeedtest
#CONFIG_PACKAGE_luci-app-netspeedtest=y

#parentcontrol
#CONFIG_PACKAGE_luci-app-parentcontrol=y

#mwan3
#CONFIG_PACKAGE_luci-i18n-mwan3-zh-cn=y

# adguardhome
#CONFIG_PACKAGE_luci-app-adguardhome=y
#CONFIG_PACKAGE_luci-i18n-adguardhome-zh-cn=y

# mosdns
# CONFIG_PACKAGE_luci-app-mosdns=y
# CONFIG_PACKAGE_luci-i18n-mosdns-zh-cn=y

# rclone
CONFIG_PACKAGE_rclone=y
CONFIG_PACKAGE_fuse3-utils=y

#SAMBA4
CONFIG_PACKAGE_luci-app-samba4=y

#luci-app-mosdns
CONFIG_PACKAGE_luci-app-mosdns=y

#SSR-PLUS

#CONFIG_PACKAGE_luci-app-ssr-plus=y
#CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_libustream-openssl=y
#CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks_Rust_Client=y
#CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks_Libev_Server=y
#CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Xray=y
#CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ChinaDNS_NG=y
#CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_MosDNS=y
#CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks_Simple_Obfs=y
#CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Libev_Client=y
#CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Libev_Server=y

" >> .config

# 移除 ddns 和 ddnsto
# sed -i 's/CONFIG_PACKAGE_ddns-scripts=y/CONFIG_PACKAGE_ddns-scripts=n/' .config
# sed -i 's/CONFIG_PACKAGE_ddns-scripts-cloudflare=y/CONFIG_PACKAGE_ddns-scripts-cloudflare=n/' .config
# sed -i 's/CONFIG_PACKAGE_ddns-scripts-dnspod=y/CONFIG_PACKAGE_ddns-scripts-dnspod=n/' .config
# sed -i 's/CONFIG_PACKAGE_ddns-scripts-services=y/CONFIG_PACKAGE_ddns-scripts-services=n/' .config
# sed -i 's/CONFIG_PACKAGE_ddns-scripts_aliyun=y/CONFIG_PACKAGE_ddns-scripts_aliyun=n/' .config
# sed -i 's/CONFIG_PACKAGE_luci-app-ddns=y/CONFIG_PACKAGE_luci-app-ddns=n/' .config
# sed -i 's/CONFIG_PACKAGE_luci-i18n-ddns-zh-cn=y/CONFIG_PACKAGE_luci-i18n-ddns-zh-cn=n/' .config

# sed -i 's/CONFIG_PACKAGE_ddnsto=y/CONFIG_PACKAGE_ddnsto=n/' .config
# sed -i 's/CONFIG_PACKAGE_luci-app-ddnsto=y/CONFIG_PACKAGE_luci-app-ddnsto=n/' .config
# sed -i 's/CONFIG_PACKAGE_luci-i18n-ddnsto-zh-cn=y/CONFIG_PACKAGE_luci-i18n-ddnsto-zh-cn=n/' .config

# 移除 bootstrap 主题
sed -i 's/CONFIG_PACKAGE_luci-theme-bootstrap=y/CONFIG_PACKAGE_luci-theme-bootstrap=n/' .config

# 移除网卡驱动
# sed -i 's/CONFIG_PACKAGE_kmod-ath=y/CONFIG_PACKAGE_kmod-ath=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-ath10k=y/CONFIG_PACKAGE_kmod-ath10k=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-board-qca9888=y/CONFIG_PACKAGE_ath10k-board-qca9888=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-board-qca988x=y/CONFIG_PACKAGE_ath10k-board-qca988x=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-board-qca9984=y/CONFIG_PACKAGE_ath10k-board-qca9984=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-firmware-qca9888=y/CONFIG_PACKAGE_ath10k-firmware-qca9888=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-firmware-qca988x=y/CONFIG_PACKAGE_ath10k-firmware-qca988x=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-firmware-qca9984=y/CONFIG_PACKAGE_ath10k-firmware-qca9984=n/' .config

# sed -i 's/CONFIG_PACKAGE_iw=y/CONFIG_PACKAGE_iw=n/' .config
# sed -i 's/CONFIG_PACKAGE_iwinfo=y/CONFIG_PACKAGE_iwinfo=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-iwlwifi=y/CONFIG_PACKAGE_kmod-iwlwifi=n/' .config
# sed -i 's/CONFIG_PACKAGE_iwlwifi-firmware-ax101=y/CONFIG_PACKAGE_iwlwifi-firmware-ax101=n/' .config
# sed -i 's/CONFIG_PACKAGE_iwlwifi-firmware-ax200=y/CONFIG_PACKAGE_iwlwifi-firmware-ax200=n/' .config
# sed -i 's/CONFIG_PACKAGE_iwlwifi-firmware-ax201=y/CONFIG_PACKAGE_iwlwifi-firmware-ax201=n/' .config
# sed -i 's/CONFIG_PACKAGE_iwlwifi-firmware-ax210=y/CONFIG_PACKAGE_iwlwifi-firmware-ax210=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8192c-common=y/CONFIG_PACKAGE_kmod-rtl8192c-common=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8192cu=y/CONFIG_PACKAGE_kmod-rtl8192cu=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8192de=y/CONFIG_PACKAGE_kmod-rtl8192de=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8192se=y/CONFIG_PACKAGE_kmod-rtl8192se=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8812au-ct=y/CONFIG_PACKAGE_kmod-rtl8812au-ct=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8821ae=y/CONFIG_PACKAGE_kmod-rtl8821ae=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8xxxu=y/CONFIG_PACKAGE_kmod-rtl8xxxu=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtlwifi=y/CONFIG_PACKAGE_kmod-rtlwifi=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtlwifi-btcoexist=y/CONFIG_PACKAGE_kmod-rtlwifi-btcoexist=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtlwifi-pci=y/CONFIG_PACKAGE_kmod-rtlwifi-pci=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtlwifi-usb=y/CONFIG_PACKAGE_kmod-rtlwifi-usb=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtw88=y/CONFIG_PACKAGE_kmod-rtw88=n/' .config

# sed -i 's/CONFIG_PACKAGE_kmod-mt7915e=y/CONFIG_PACKAGE_kmod-mt7915e=n/' .config

# sed -i 's/CONFIG_PACKAGE_kmod-mt7921-common=y/CONFIG_PACKAGE_kmod-mt7921-common=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-mt7921-firmware=y/CONFIG_PACKAGE_kmod-mt7921-firmware=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-mt7921e=y/CONFIG_PACKAGE_kmod-mt7921e=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-mt7921u=y/CONFIG_PACKAGE_kmod-mt7921u=n/' .config
