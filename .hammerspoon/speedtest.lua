local home = os.getenv("HOME")
local main = nil
local launchctl = require("launchctl")
local add_job = launchctl.add_job
local results_location = home .. "/.bin/speedtest.json"

SPEEDTEST_MENU = hs.menubar.new()

add_job("com.darrinholst.dont-effin-delete-me", {
  StartInterval = 300,
  WorkingDirectory = home .. "/.bin",
  ProgramArguments = { "bash", "-c", "/opt/homebrew/bin/speedtest -f json > " .. results_location },
  StandardErrorPath = home .. "/.bin/log/speedtest.log",
  StandardOutPath = home .. "/.bin/log/speedtest.log",
})

local function mbps(n)
  return string.format("%.0f", n * 8 / 1000000)
end

main = function()
  pcall(function()
    local file = io.open(results_location, "r")

    if file then
      local results = file:read("*all")
      io.close(file)
      local json = hs.json.decode(results)
      local isp = json.isp:match("%S+")
      SPEEDTEST_MENU:setTitle(
        isp .. ": " .. mbps(json.download.bandwidth) .. "↓ " .. mbps(json.upload.bandwidth) .. "↑"
      )
    end
  end)
end

SPEEDTEST_TIMER = hs.timer.new(30, main)
SPEEDTEST_TIMER:start()
