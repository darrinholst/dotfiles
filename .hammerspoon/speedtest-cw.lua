local home = os.getenv("HOME")
local main = nil
local launchctl = require("launchctl")
local add_job = launchctl.add_job
local results_location = home .. "/.bin/speedtest/results.json"

SPEEDTEST_CW_MENU = hs.menubar.new()

add_job("com.darrinholst.speedtest", {
  StartInterval = 30,
  WorkingDirectory = home .. "/.bin/speedtest",
  EnvironmentVariables = {
    AWS_PROFILE = "dlh",
    AWS_SHARED_CREDENTIALS_FILE = home .. "/.aws/credentials",
  },
  ProgramArguments = { "bash", "-c", "./cloudwatch > " .. results_location },
  StandardErrorPath = home .. "/.bin/speedtest/stderr.log",
  StandardOutPath = home .. "/.bin/speedtest/stdout.log",
})

main = function()
  pcall(function()
    local file = io.open(results_location, "r")

    if file then
      local results = file:read("*all")
      io.close(file)
      local json = hs.json.decode(results)
      local isp = json.isp
      SPEEDTEST_CW_MENU:setTitle(
        isp .. ": " .. json.download .. "↓ " .. json.upload .. "↑ " .. math.ceil(json.ping) .. "p"
      )
    end
  end)
end

SPEEDTEST_TIMER = hs.timer.new(30, main)
SPEEDTEST_TIMER:start()
