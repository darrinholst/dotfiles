DNS_TIMER = hs.timer.doEvery(60, function()
  hs.execute("dns-refresh", true)
end)
