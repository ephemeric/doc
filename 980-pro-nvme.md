wget https://s3.ap-northeast-2.amazonaws.com/global.semi.static/SAMSUNG_BRAND_SSD_980PRO_ISO/FW/E2512E718DB3E7EWGAJLDA8A7108M1Y2D9M9090J2KIA55338/Samsung_SSD_980_PRO_3B2QGXA7.iso

mkdir /mnt/iso

sudo mount -o loop ./Samsung_SSD_980_PRO_3B2QGXA7.iso /mnt/iso/

mkdir /tmp/fwupdate

cd /tmp/fwupdate

gzip -dc /mnt/iso/initrd | cpio -idv --no-absolute-filenames

cd root/fumagician/

sudo ./fumagician
