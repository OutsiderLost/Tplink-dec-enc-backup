#!/usr/bin/lua

local firm = require "luci.controller.admin.firmware"
local cry = require "luci.model.crypto"
local configtool = require "luci.sys.config"
local fs = require "luci.fs"
local util = require "luci.util"
local uci = require "luci.model.uci"
local uci_r = uci.cursor()
local BACKUP_ORIGIN_FILENAME = "/root/backup.decrypted"
local BACKUP_BINARY_FILENAME = "/root/new_config.bin"

os.execute("[ -f /root/tmp/user-config.xml ] || exit")
print("\ntar special compressed USER CONFIG XML FILE -> ORI BACKUP USER CONFIG...\n")

os.execute("[ `pwd` != '/root' ] && [ -d tmp ] && mv tmp tmp01")
os.execute("[ `pwd` = '/root' ] || mv /root/tmp ./")
-- os.execute("[ `pwd` = '/' ] && mv /root/tmp /")
os.execute("[ -f ./tmp/user-config.xml ] || exit")
os.execute("[ -f ori-backup-user-config ] && rm ori-backup-user-config")
-- os.execute("tar -b1 -cvf ori-backup-user-config -C . tmp/user-config.xml")
os.execute("tar -cvf ori-backup-user-config -C . tmp/user-config.xml")
os.execute("[ -f ori-backup-user-config ] || exit")
os.execute("[ `pwd` = '/root' ] || mv tmp /root/")
os.execute("[ -d tmp01 ] && mv tmp01 tmp")

os.execute("[ -f ori-backup-user-config.gz ] && rm ori-backup-user-config.gz")
print("\ncontinous gzip compressed ORI BACKUP USER CONFIG...\n")
os.execute("gzip -n9 ori-backup-user-config")
os.execute("[ -f ori-backup-user-config.gz ] || exit")

os.execute("[ -f ori-backup-user-config.bin ] && rm ori-backup-user-config.bin")
print("\nrename ORI BACKUP USER CONFIG FILE...\n")
os.execute("mv ori-backup-user-config.gz ori-backup-user-config.bin")

os.execute("[ -d oris ] && rm -r oris")
print("\ncopy together ORI BACKUP CERTIFICATE FILE  &  ORI BACKUP USER CONFIG FILE...\n")
os.execute("mkdir oris")
os.execute("[ -f ori-backup-certificate.bin ] || exit")
os.execute("[ -f ori-backup-certificate.bin ] || cp /root/ori-backup-certificate.bin ./")
-- os.execute("cp {ori-backup-certificate.bin,ori-backup-user-config.bin} oris")
os.execute("cp ori-backup-certificate.bin ori-backup-user-config.bin oris")


os.execute("[ `pwd` != '/root' ] && [ -f backup.decrypted ] && rm backup.decrypted")
os.execute("[ `pwd` = '/root' ] && [ -f /root/backup.decrypted ] && rm /root/backup.decrypted")
print('\nfinal tar special compressed together copied files -> root/"ORIGINAL BACKUP DECRYPTED FILE" :-)\n')
-- os.execute("tar -b1 -cvf backup.decrypted -C oris .")
os.execute("tar -cvf backup.decrypted -C oris .")
os.execute("[ -f backup.decrypted ] || exit")
os.execute("[ `pwd` = '/root' ] || mv backup.decrypted /root/backup.decrypted")
os.execute("[ -f /root/backup.decrypted ] || exit")

print('\nencrypted ORIGINAL BACKUP DECRYPTED FILE -> /root/"BACKUP BINARY FILE"\n')
cry.enc_file(BACKUP_ORIGIN_FILENAME, BACKUP_BINARY_FILENAME, "0123456789abcdef    ")


-- luci.sys.exec("mkdir /tmp/commandtest")

-- os.exit()
