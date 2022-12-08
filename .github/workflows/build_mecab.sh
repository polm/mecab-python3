#!/bin/bash
# Install mecab
set -e
manylinux_version=2014
plat=x86_64

# install MeCab
# TODO specify the commit used here
git clone --depth=1 https://github.com/taku910/mecab.git
cd mecab/mecab
if [ `uname -m` == 'aarch64' ]; then
  manylinux_version=2014
  plat=aarch64
  yum -y update && yum install -y wget
  wget 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD' -O config.guess
  wget 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD' -O config.sub
fi

cd ../../
mv mecab /github/workspace/mecab_$plat
cd mecab_$plat/mecab/

./configure --enable-utf8-only
make
