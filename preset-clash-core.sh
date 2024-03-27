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

CLASH_DEV_URL="https://github.com/vernesong/OpenClash/raw/core/master/dev/clash-linux-amd64-v3.tar.gz"
CLASH_TUN_URL="https://github.com/vernesong/OpenClash/raw/core/master/premium/clash-linux-amd64-v3-2023.08.17-13-gdcc8d87.gz"
CLASH_META_URL="https://github.com/vernesong/OpenClash/raw/core/master/meta/clash-linux-amd64-v3.tar.gz"
GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"

wget -qO- $CLASH_DEV_URL | tar xOvz > $core_path/clash
wget -qO- $CLASH_TUN_URL | gunzip -c > $core_path/clash_tun
wget -qO- $CLASH_META_URL | tar xOvz > $core_path/clash_meta
# wget $CLASH_DEV_URL && tar xOvz $(basename $CLASH_DEV_URL) > $core_path/clash && rm $(basename $CLASH_DEV_URL)
# wget $CLASH_TUN_URL && gunzip -c $(basename $CLASH_TUN_URL) > $core_path/clash_tun && rm $(basename $CLASH_TUN_URL)
# wget $CLASH_META_URL && tar xOv $(basename $CLASH_META_URL) > $core_path/clash_meta && rm $(basename $CLASH_META_URL)
wget -qO- $GEOIP_URL > $goe_path/GeoIP.dat
wget -qO- $GEOSITE_URL > $goe_path/GeoSite.dat

chmod +x $core_path/clash*
