# Tplink-dec-enc-backup
# linux-mips debian in shell backup dec and encrypted automatization scripts.
# Example -> Archer C5 - C7, etc...
# (more information: blog.dsinf.net)
=================================================

# Before lua scripts run
chroot . ./bin/sh
chmod +x *.lua
# Before bash scripts run
exit # back in linux-mips bash
chmod +x *.sh

# "backup" file place in -> squashfs-root/root/ and rename in scripts "backup-ArcherType-YYYY-MM-DD.bin"
# (decoding process in one with extracted methods)
./firm-dec-PLUS.lua
# (or, separate (recommended))
./firm-dec-1A.lua
./dec-bash-2A.sh

# Encoding process (may rename encoding outfile in script -> "new_config.bin")
./firm-enc-PLUS.lua
# (or, separate (recommended))
./enc-bash-1B.sh
./firm-enc-2B.lua

# Certain scripts can be run in router opened Remote SSH:
./firm-dec-PLUS.lua
./firm-enc-PLUS.lua
./firm-dec-1A.lua
./firm-enc-1B.lua
=================================================

# Other description:
The scripts were written to delete or overwrite files it did not need.
It works where it is started ("squashfs-root"/root/ or "squashfs-root"/)
and always puts the final file in -> "squashfs-root"/root/.
So where you first worked, you have to continue with that and it will work.
("squashfs-root"/root/ or "squashfs-root"/)
It is recommended to run everything in "squashfs-root"/root/ !!!

Warning! There PLUS version of 'firm-enc' the 'router firmware sh' does not support complicated recompression procedures.
(So this recommended done under 'linux-mips or other linux' do the separate scripts: 'enc-bash-1B.sh -> firm-enc-2B.lua' !)

Other linux conversion with scripts:
create a 'root' folder, paste scripts and necessary files (backup.decrypted or modied tmp/xml, certificate files)
-------------------------------------------------

# Other fast transcript commands for help working:
sed -i 's/backup-ArcherType-YYYY-MM-DD.bin/<my-backupfile>/g' *.lua
sed -i 's/new_config.bin/<my-new-backupfile>/g' *.lua

