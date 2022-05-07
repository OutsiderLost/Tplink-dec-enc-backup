#!/usr/bin/lua

local firm = require "luci.controller.admin.firmware"
local cry = require "luci.model.crypto"
local configtool = require "luci.sys.config"
local fs = require "luci.fs"
local util = require "luci.util"
local uci = require "luci.model.uci"
local uci_r = uci.cursor()
local BACKUP_BINARY_FILENAME = "/root/backup-ArcherType-YYYY-MM-DD.bin"
local BACKUP_ORIGIN_FILENAME = "/root/backup.decrypted"

print("\ncreate ORIGINAL BACKUP DECRYPTED FILE\n")
cry.dec_file(BACKUP_BINARY_FILENAME, BACKUP_ORIGIN_FILENAME, "0123456789abcdef    ")

os.execute("[ -f /root/backup.decrypted ] || exit")
print("\ntar extract ORIGINAL BACKUP DECRYPTED FILE...\n")
os.execute("[ -f ori-backup-user-config.bin ] && rm ori-backup-user-config.bin")
os.execute("[ -f ori-backup-user-conf.bin ] && rm ori-backup-user-conf.bin")
os.execute("[ -f ori-backup-user-config ] && rm ori-backup-user-config")
os.execute("[ -f ori-backup-user-conf ] && rm ori-backup-user-conf")
os.execute("[ -f ori-backup-certificate.bin ] && rm ori-backup-certificate.bin")
os.execute("[ -f ori-backup-user-config.gz ] && rm ori-backup-user-config.gz")
os.execute("tar xvf /root/backup.decrypted")

print("\nrename extracted ORI BACKUP USER CONFIG...\n(Warning !!! filename may differ !!!)\n")
os.execute("[ -f ori-backup-user-config.bin ] && mv ori-backup-user-config.bin ori-backup-user-config.gz")
os.execute("[ -f ori-backup-user-conf.bin ] && mv ori-backup-user-conf.bin ori-backup-user-config.gz")

print("gzip extracted ORI BACKUP USER CONFIG...")
os.execute("gzip -d ori-backup-user-config.gz")

print("\ncontinous final tar extracted ORI BACKUP USER CONFIG...\n")
os.execute("[ -f /root/tmp/user-config.xml ] && rm -r /root/tmp")
os.execute("tar xvf ori-backup-user-config -C /root/")
os.execute("[ -f /root/tmp/user-config.xml ] && echo -e '\nextracted USER CONFIG XML FILE -> root/tmp/user-config.xml :-)\n'")
os.execute("[ -f /root/tmp/user-config.xml ] || echo -e '\nsomethig error !!! no found USER CONFIG XML FILE !!!\n'")

-- luci.sys.exec("mkdir /tmp/commandtest")

-- os.exit()
