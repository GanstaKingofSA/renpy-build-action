#!/bin/sh

sdk_name=renpy-$1-sdk
echo "Downloading the specified SDK (${sdk_name})..."
wget -q https://www.renpy.org/dl/$1/${sdk_name}.tar.bz2
clear

echo "Downloaded SDK version (${sdk_name})."
echo "Setting up the specified SDK (${sdk_name})..."
tar -xf ./${sdk_name}.tar.bz2
rm ./${sdk_name}.tar.bz2
mv ./${sdk_name} ../renpy
ls -l
mkdir ddmm
cp -vRf /* ddmm
rm ddmm/renpy.sh
rm -r ddmm/lib
mv ./renpy/renpy.sh ddmm/renpy.sh
mv ./renpy/lib ddmm/lib
cd ./ddmm
echo "Building the project at $2..."
if ../renpy.sh ../renpy/launcher distribute; then
    built_dir=$(ls | grep '\-dists')
    echo ::set-output name=dir::$built_dir
    echo ::set-output name=version::${built_dir%'-dists'}
else
    return 1
fi
