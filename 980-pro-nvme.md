cd ~/tmp

wget ...

mkdir loop

sudo mount -o loop Samsung_SSD_980_PRO_3B2QGXA7.iso loop

cd loop

gzip -dc initrd | cpio -idv --no-absolute-filenames

cd root/fumagician/

sudo ./fumagician
