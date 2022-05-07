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

print('\nencrypted ORIGINAL BACKUP DECRYPTED FILE -> /root/"BACKUP BINARY FILE" :-)\n')
cry.enc_file(BACKUP_ORIGIN_FILENAME, BACKUP_BINARY_FILENAME, "0123456789abcdef    ")

-- luci.sys.exec("mkdir /tmp/commandtest")

-- os.exit()
