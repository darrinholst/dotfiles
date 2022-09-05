CONFIG_RELOADER = require("config-reloader")
SLACK_STATUS = require("slack-status")
AWS = require("aws")
VPN = require("vpn")

hs.hotkey.bind({ "cmd", "alt" }, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)
