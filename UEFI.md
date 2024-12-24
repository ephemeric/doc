 9891  pwd
 9892  mokutil --import /var/lib/sbctl/keys/db/db.slob
 9893  openssl -inform pem -in db.pem -outform der -out db.der
 9894  openssl -in db.pem -outform der -out db.der
 9895  openssl x509 -inform pem -in db.pem -outform der -out db.der
 9896  ls -l
 9897  sbctl sign
 9898  sbctl sign /boot/vmlinuz-5.14.0-503.15.1.slob.el9.x86_64
 9899  sbctl verify /boot/vmlinuz-5.14.0-503.15.1.slob.el9.x86_64
 9900  reboot
 9901  pesigcheck -i /boot/efi/EFI/almalinux/shim.efi
 9902  pesigcheck -i /boot/efi/EFI/almalinux/shimx64-almalinux.efi
 9903  sbverify
 9904  sbverify  --list /boot/efi/EFI/almalinux/shim.efi
 9905  sbverify  --list /boot/efi/EFI/almalinux/shimx64-almalinux.efi
 9906  rpm -qf /boot/efi/EFI/almalinux/shimx64-almalinux.efi
 9907  pesigcheck -i /boot/efi/EFI/almalinux/shimx64.efi
 9908  sbverify  --list /boot/efi/EFI/almalinux/shimx64.efi
 9909  ukify
 9910  ukify build \\n                 --linux=/lib/modules/6.0.9-300.fc37.x86_64/vmlinuz \\n                 --initrd=/some/path/initramfs-6.0.9-300.fc37.x86_64.img \\n--cmdline='rw'
 9911  ukify build --linux=/lib/modules/5.14.0-503.15.1.slob.el9.x86_64/vmlinuz --initrd=/boot/initramfs-5.14.0-503.15.1.slob.el9.x86_64.img --cmdline='rw'
 9912  mv vmlinuz.unsigned.efi vmlinuz-5.14.0-503.15.1.slob.el9.x86_64
 9913  mv vmlinuz-5.14.0-503.15.1.slob.el9.x86_64 uki-5.14.0-503.15.1.slob.el9.x86_64
 9914  mkdir /boot/efi/EFI/Linux/
 9915  efibootmgr --create --disk /dev/sda --label "slob" --loader '\EFI\Linux\uki-5.14.0-503.15.1.slob.el9.x86_64' --unicode
 9916  ls -l /boot/efi
 9917  ls -l /boot/efi/EFI/Linux
 9918  mkdir -p /boot/EFI/Linux/
 9919  cp /boot/efi/EFI/Linux/uki-5.14.0-503.15.1.slob.el9.x86_64 /boot/EFI/Linux
 9920  sbverify  --list /boot/EFI/Linux/uki-5.14.0-503.15.1.slob.el9.x86_64
 9921  sbverify  --list /boot/efi/EFI/Linux/uki-5.14.0-503.15.1.slob.el9.x86_64
 9922  sudo reboot
 9923  ukify build --linux=/lib/modules/5.14.0-503.15.1.slob.el9.x86_64/vmlinuz --initrd=/boot/initramfs-5.14.0-503.15.1.slob.el9.x86_64.img
 9924  mv vmlinuz.unsigned.efi uki-5.14.0-503.15.1.slob.el9.x86_64
 9925  mv uki-5.14.0-503.15.1.slob.el9.x86_64 /boot/efi/EFI/Linux/
 9926  sbctl sign /boot/efi/EFI/Linux/uki-5.14.0-503.15.1.slob.el9.x86_64
 9927  df -hT
 9928  rm /boot/EFI/Linux/uki-5.14.0-503.15.1.slob.el9.x86_64
 9929  rmdir  /boot/EFI/Linux/
 9930  rmdir  /boot/EFI
 9931  rmdir  /boot/
 9932  sbctl verify /boot/efi/EFI/Linux/uki-5.14.0-503.15.1.slob.el9.x86_64
 9933  cat /rpc/keys
 9934  cat /proc/keys
 9935  cd /boot/efi/EFI
 9936  cd Linux
 9937  rm uki-5.14.0-503.15.1.slob.el9.x86_64
 9938  ukify build --linux=/lib/modules/5.14.0-503.15.1.slob.el9.x86_64/vmlinuz --initrd=/boot/initramfs-5.14.0-503.15.1.slob.el9.x86_64.img --cmdline='root=/dev/mapper/almalinux-root ro crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M resume=/dev/mapper/almalinux-swap rd.lvm.lv=almalinux/root rd.lvm.lv=almalinux/swap'
 9939  man ukify
 9940  uname -r
 9941  ukify build --name=5.14.0-503.15.1.slob.el9.x86_64 --linux=/lib/modules/5.14.0-503.15.1.slob.el9.x86_64/vmlinuz --initrd=/boot/initramfs-5.14.0-503.15.1.slob.el9.x86_64.img --cmdline='root=/dev/mapper/almalinux-root ro crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M resume=/dev/mapper/almalinux-swap rd.lvm.lv=almalinux/root rd.lvm.lv=almalinux/swap'
 9942  ukify build --uname=5.14.0-503.15.1.slob.el9.x86_64 --linux=/lib/modules/5.14.0-503.15.1.slob.el9.x86_64/vmlinuz --initrd=/boot/initramfs-5.14.0-503.15.1.slob.el9.x86_64.img --cmdline='root=/dev/mapper/almalinux-root ro crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M resume=/dev/mapper/almalinux-swap rd.lvm.lv=almalinux/root rd.lvm.lv=almalinux/swap'
 9943  man efibootmgr
 9944  efibootmgr -B Boot000A
 9945  efibootmgr -B -b Boot000A
 9946  efibootmgr -b Boot000A
 9947  efibootmgr -B 000A
 9948  dnf install kernel
 9949  cd /boot
 9950  cp vmlinuz-5.14.0-503.15.1.slob.el9.x86_64 nosig-5.14.0-503.15.1.slob.el9.x86_64
 9951  sbattach
 9952  sbattach --remove
 9953  sbattach --remove nosig-5.14.0-503.15.1.slob.el9.x86_64
 9954  sbctl verify vmlinuz.unsigned.efi
 9955  file vmlinuz.unsigned.efi
 9956  sbctl verify help
 9957  sbctl help
 9958  sbctl verify --help
 9959  sbctl verify
 9960  pesigcheck -i vmlinuz.unsigned.efi
 9961  sbverify  --list vmlinuz.unsigned.efi
 9962  sbattach --remove ../../../vmlinuz-5.14.0-503.15.1.slob.el9.x86_64
 9963  sbctl sign ../../../vmlinuz-5.14.0-503.15.1.slob.el9.x86_64
 9964  sbverify  --list ../../../vmlinuz-5.14.0-503.15.1.slob.el9.x86_64
 9965  efibootmgr -v
 9966  dnf search kernel
 9967  dnf install kernel.x86_64
 9968  mokutil --import db.der
 9969  cd /var/lib/sbctl/keys/db
 9970  cp db.der /boot/efi/EFI/
 9971  cd
 9972  poweroff
 9973  sbctl  setup
 9974  sbctl setup --help
 9975  sbctl setup --setup
 9976  sbctl
 9977  sbctl
 9978  ll
 9979  ukify build --uname=nosig-5.14.0-503.15.1.slob.el9.x86_64 --linux=/lib/modules/5.14.0-503.15.1.slob.el9.x86_64/vmlinuz --initrd=/boot/initramfs-5.14.0-503.15.1.slob.el9.x86_64.img --cmdline=''
 9980  vi /boot/grub2/grub.cfg
 9981  vi /etc/default/grub
 9982  ukify build --uname=nosig-5.14.0-503.15.1.slob.el9.x86_64 --linux=/lib/modules/5.14.0-503.15.1.slob.el9.x86_64/vmlinuz --initrd=/boot/initramfs-5.14.0-503.15.1.slob.el9.x86_64.img --cmdline='crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M resume=/dev/mapper/almalinux-swap rd.lvm.lv=almalinux/root rd.lvm.lv=almalinux/swa'
 9983  sbctl  enroll-keys
 9984  bootctl
 9985  sbctl status
 9986  sbctl  list-enrolled-keys
 9987  ukify build --uname=nosig-5.14.0-503.15.1.slob.el9.x86_64 --linux=/lib/modules/5.14.0-503.15.1.slob.el9.x86_64/vmlinuz --initrd=/boot/initramfs-5.14.0-503.15.1.slob.el9.x86_64.img --cmdline='crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M resume=/dev/mapper/almalinux-swap rd.lvm.lv=almalinux/root rd.lvm.lv=almalinux/swap'
 9988  efibootmgr --create --disk /dev/sda --label "slob" --loader '\EFI\Linux\vmlinuz.unsigned.efi' --unicode
 9989  cd /boot/efi/EFI/Linux
 9990  ukify build --uname=nosig-5.14.0-503.15.1.slob.el9.x86_64 --linux=/lib/modules/5.14.0-503.15.1.slob.el9.x86_64/vmlinuz --initrd=/boot/initramfs-5.14.0-503.15.1.slob.el9.x86_64.img
 9991  #efibootmgr --create --disk /dev/sda --label "slob" --loader '\EFI\Linux\vmlinuz.unsigned.efi' --unicode
 9992  cat /etc/default/grub
 9993  cat /proc/cmdline
 9994  efibootmgr -B -b 000A
 9995  efibootmgr -B -b 0009
 9996  efibootmgr --create --disk /dev/sda --label "slob" --loader '\EFI\Linux\vmlinuz.unsigned.efi' --unicode 'root=/dev/mapper/almalinux-root ro resume=/dev/mapper/almalinux-swap rd.lvm.lv=almalinux/root rd.lvm.lv=almalinux/swap'
 9997  sbverify  --list /boot/nosig-5.14.0-503.15.1.slob.el9.x86_64
 9998  sbctl sign vmlinuz.unsigned.efi
 9999  sbctl  enroll-keys --yes-this-might-brick-my-machine
