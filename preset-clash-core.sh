#!/bin/bash
#=================================================
# File name: perest-clash-core.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================

echo -e "预置Clash内核"
mkdir -p feeds/openclash/luci-app-openclash/root/etc/openclash/core
core_path="feeds/openclash/luci-app-openclash/root/etc/openclash/core"
goe_path="feeds/openclash/luci-app-openclash/root/etc/openclash"

CLASH_DEV_URL="https://github.com/vernesong/OpenClash/blob/core/master/dev/clash-linux-${1}.tar.gz"
#CLASH_DEV_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-${1}.tar.gz"
#CLASH_TUN_URL=$(curl -fsSL https://api.github.com/repos/vernesong/OpenClash/contents/master/premium\?ref\=core | grep download_url | grep $1 | awk -F '"' '{print $4}' | grep "v3" )
CLASH_TUN_UR="https://github.com/vernesong/OpenClash/blob/core/master/premium/clash-linux-amd64-2023.08.17-13-gdcc8d87.gz"
#CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-${1}.tar.gz"
CLASH_META_URL="https://github.com/vernesong/OpenClash/blob/core/master/meta/clash-linux-amd64-v3.tar.gz"
GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"

# wget -qO- $CLASH_DEV_URL | tar xOvz > $core_path/clash
# wget -qO- $CLASH_TUN_URL | gunzip -c > $core_path/clash_tun
# wget -qO- $CLASH_META_URL | tar xOvz > $core_path/clash_meta
wget $CLASH_DEV_URL && tar xOvz $(basename $CLASH_DEV_URL) > $core_path/clash && rm $(basename $CLASH_DEV_URL)
wget $CLASH_TUN_URL && gunzip -c $(basename $CLASH_TUN_URL) > $core_path/clash_tun && rm $(basename $CLASH_TUN_URL)
wget $CLASH_META_URL && tar xOv $(basename $CLASH_META_URL) > $core_path/clash_meta && rm $(basename $CLASH_META_URL)
wget -qO- $GEOIP_URL > $goe_path/GeoIP.dat
wget -qO- $GEOSITE_URL > $goe_path/GeoSite.dat

chmod +x $core_path/clash*
