#!/bin/bash

#编译evil
echo 正在编译evil...
cd evil && make

#ibus.el插件需要安装python-xlib
echo 正在安装python-xlib
sudo apt-get install python-xlib
