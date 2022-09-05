local function login(profile)
  local _, status = hs.execute("aws sso login --profile " .. profile .. " && aws --profile " .. profile .. " s3 ls", true)
  hs.alert(status and "👍" or "👎")
end

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "t", function() login("test") end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "p", function() login("prod") end)
