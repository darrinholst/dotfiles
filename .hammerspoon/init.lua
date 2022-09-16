CONFIG_RELOADER = require("config-reloader")
SLACK_STATUS = require("slack-status")
VPN = require("vpn")

hs.hotkey.bind({ "cmd", "alt" }, "V", function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "n", function()
  hs.screen.primaryScreen():setBrightness(0.1)
  hs.screen.primaryScreen():setBrightness(1)
  hs.screen:primaryScreen():setMode(2560, 1440, 2.0, 60.0, 8.0)
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "m", function()
  hs.screen.primaryScreen():setBrightness(0.1)
  hs.screen.primaryScreen():setBrightness(1)
  hs.screen:primaryScreen():setMode(2048, 1152, 2.0, 60.0, 8.0)
end)

hs.notify.show("Loaded", "", "")
