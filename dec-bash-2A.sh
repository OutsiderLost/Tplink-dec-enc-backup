#!/bin/bash

# filename -> backup.decrypted

echo -e '\ntar extract ORIGINAL BACKUP DECRYPTED FILE...\n'
varvalue1="$(echo $(pwd) | sed 's/.*/&OK/g;/\/rootOK/!d' | wc -l)"
if [ "$varvalue1" = "1" ]; then
  [ -f backup.decrypted ] || exit
else
  [ -f root/backup.decrypted ] || exit
fi

[ -f ori-backup-user-config.bin ] && rm ori-backup-user-config.bin
[ -f ori-backup-user-conf.bin ] && rm ori-backup-user-conf.bin
[ -f ori-backup-user-config ] && rm ori-backup-user-config
[ -f ori-backup-user-conf ] && rm ori-backup-user-conf
[ -f ori-backup-certificate.bin ] && rm ori-backup-certificate.bin
[ -f ori-backup-user-config.gz ] && rm ori-backup-user-config.gz

if [ "$varvalue1" = "1" ]; then
  tar xvf backup.decrypted
else
  tar xvf root/backup.decrypted
fi

echo -e '\nrename extracted ORI BACKUP USER CONFIG...\n(Warning !!! filename may differ !!!)\n'
[ -f ori-backup-user-config.bin ] && mv ori-backup-user-config.bin ori-backup-user-config.gz
[ -f ori-backup-user-conf.bin ] && mv ori-backup-user-conf.bin ori-backup-user-config.gz

echo -e'gzip extracted ORI BACKUP USER CONFIG...'
gzip -d ori-backup-user-config.gz

echo -e '\ncontinous final tar extracted ORI BACKUP USER CONFIG...\n'
if [ "$varvalue1" = "1" ]; then
  [ -f tmp/user-config.xml ] && rm -r tmp
  tar xvf ori-backup-user-config
  [ -f tmp/user-config.xml ] && echo -e '\nextracted USER CONFIG XML FILE -> root/tmp/user-config.xml :-)\n'
  [ -f tmp/user-config.xml ] || echo -e '\nsomethig error !!! no found USER CONFIG XML FILE !!!\n'
else
  [ -f root/tmp/user-config.xml ] && rm -r root/tmp
  tar xvf ori-backup-user-config -C root/
  [ -f root/tmp/user-config.xml ] && echo -e '\nextracted USER CONFIG XML FILE -> root/tmp/user-config.xml :-)\n'
  [ -f root/tmp/user-config.xml ] || echo -e '\nsomethig error !!! no found USER CONFIG XML FILE !!!\n'
fi
