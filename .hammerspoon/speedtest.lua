local main = nil
SPEEDTEST_MENU = hs.menubar.new()

main = function()
  local results = hs.execute("/opt/homebrew/bin/speedtest -f json")
  local json = hs.json.decode(results)
  print(hs.inspect(json))
  SPEEDTEST_MENU:setTitle(json.isp .. string.format(": %.0f", json.download.bandwidth * 8 / 1000000))
end

SPEEDTEST_TIMER = hs.timer.new(300, main)
SPEEDTEST_TIMER:start()
main()
