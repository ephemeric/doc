# Rsync.

rsync -cvae ssh --chmod=D0755,F0644 --exclude="*.j2" --delete-after --progress --out-format="[%t]:%o:%f:Last Modified %M" src dst:tmp/
