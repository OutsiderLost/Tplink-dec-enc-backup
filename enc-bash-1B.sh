#!/bin/bash

varpath="$(pwd)"
echo -e "\nfist place -> $(pwd)\n"
echo -e '\ntar special compressed USER CONFIG XML FILE -> ORI BACKUP USER CONFIG...\n'

[ -f tmp/user-config.xml ] || cd root
[ -f tmp/user-config.xml ] || exit
echo -e "\nroot place -> $(pwd)\n"
[ -f ori-backup-user-config ] && rm ori-backup-user-config
tar -b1 -cvf ori-backup-user-config -C . tmp/user-config.xml
[ -f $varpath/ori-backup-user-config ] || mv ori-backup-user-config $varpath/ori-backup-user-config
[ -f $varpath/ori-backup-user-config ] || exit

cd $varpath
echo -e "\nfist place -> $(pwd)\n"
[ -f ori-backup-user-config ] || exit

echo -e '\ncontinous gzip compressed ORI BACKUP USER CONFIG...\n'
gzip -n9 ori-backup-user-config

echo -e '\nrename ORI BACKUP USER CONFIG FILE...\n'
mv ori-backup-user-config.gz ori-backup-user-config.bin

echo -e "\ncopy together ORI BACKUP CERTIFICATE FILE  &  ORI BACKUP USER CONFIG FILE...\n"
[ -d oris ] && rm -r oris
mkdir oris
cp {ori-backup-certificate.bin,ori-backup-user-config.bin} oris

echo -e '\nfinal tar special compressed together copied files -> root/"ORIGINAL BACKUP DECRYPTED FILE" :-)\n'
# check in root or /
varvalue1="$(echo $(pwd) | sed 's/.*/&OK/g;/\/rootOK/!d' | wc -l)"
if [ "$varvalue1" = "1" ]; then
[ -f backup.decrypted ] && rm backup.decrypted
tar -b1 -cvf backup.decrypted -C oris .
echo " "
else
tar -b1 -cvf backup.decrypted -C oris .
mv backup.decrypted root/backup.decrypted
echo " "
fi
