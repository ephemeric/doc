# README

https://forum.proxmox.com/threads/reduce-size-of-local-lvm.78676/#post-348810

lvremove pve/data
lvcreate -L<pool size>G -ndata pve
lvconvert --type thin-pool --poolmetadatasize <metadata size>G pve/data
