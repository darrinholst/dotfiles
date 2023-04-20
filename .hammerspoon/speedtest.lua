local main = nil
SPEEDTEST_MENU = hs.menubar.new()

local function mbps(n)
  return string.format("%.0f", n * 8 / 1000000)
end

main = function()
  pcall(function()
    local results = hs.execute("/opt/homebrew/bin/speedtest -f json")
    local json = hs.json.decode(results)
    local isp = json.isp:match("%S+")
    SPEEDTEST_MENU:setTitle(isp .. ": " .. mbps(json.download.bandwidth) .. "↓ " .. mbps(json.upload.bandwidth) .. "↑")
  end)
end

SPEEDTEST_TIMER = hs.timer.new(300, main)
SPEEDTEST_TIMER:start()
