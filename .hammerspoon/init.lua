SLACK_STATUS = require("slack-status")
CONFIG_RELOADER = require("config-reloader")
VPN = require("vpn")
DNS = require("dns")

hs.hotkey.bind({ "cmd", "alt" }, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)
