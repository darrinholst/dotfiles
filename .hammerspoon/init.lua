slack_status = require("slack-status")
config_reloader = require("config-reloader")
vpn = require("vpn")

hs.hotkey.bind({ "cmd", "alt" }, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)
