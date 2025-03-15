#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 网络配置信息，将从 zzz-default-settings 文件的第2行开始添加
sed -i "2i # network config" ./package/lean/default-settings/files/zzz-default-settings
# WAN
sed -i "3i uci set network.wan.ipaddr='192.168.0.2'" ./package/lean/default-settings/files/zzz-default-settings
sed -i "4i uci set network.wan.proto='static'" ./package/lean/default-settings/files/zzz-default-settings # 静态 IP
sed -i "5i uci set network.wan.device='eth0'" ./package/lean/default-settings/files/zzz-default-settings  # 网络端口
sed -i "6i uci set network.wan.netmask='255.255.255.0'" ./package/lean/default-settings/files/zzz-default-settings    # 子网掩码
sed -i "7i uci set network.wan.gateway='192.168.0.1'" ./package/lean/default-settings/files/zzz-default-settings  # 默认网关地址
sed -i "8i uci set network.wan.dns='192.168.0.253'" ./package/lean/default-settings/files/zzz-default-settings  # 默认上游 DNS 地址
# WAN6
sed -i "9i uci set network.wan6.device='eth0'" ./package/lean/default-settings/files/zzz-default-settings  # 网络端口
sed -i "10i uci set network.wan6.proto='dhcpv6'" ./package/lean/default-settings/files/zzz-default-settings  # dhcp
# LAN
sed -i "11i uci set network.lan.ipaddr='192.168.255.1'" ./package/lean/default-settings/files/zzz-default-settings  # 默认 IP 地址
sed -i "12i uci set network.lan.proto='static'" ./package/lean/default-settings/files/zzz-default-settings # 静态 IP
sed -i "13i uci set network.lan.device='eth1'" ./package/lean/default-settings/files/zzz-default-settings  # 网络端口
sed -i "14i uci set network.lan.netmask='255.255.255.0'" ./package/lean/default-settings/files/zzz-default-settings    # 子网掩码
sed -i "15i uci delete network.lan.ip6assign" ./package/lean/default-settings/files/zzz-default-settings    # 禁用lan口ipv6分配
# br-lan
sed -i "16i uci delete network.@device[0]" ./package/lean/default-settings/files/zzz-default-settings    # 删除br-lan设备

sed -i "17i uci commit network\n" ./package/lean/default-settings/files/zzz-default-settings
# 加入编译信息
sed -i "s/LEDE /WWW build $(TZ=UTC-8 date "+%Y.%m.%d") @ LEDE /g" package/lean/default-settings/files/zzz-default-settings
