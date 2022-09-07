local function login(profile)
  hs.notify.show("Getting credentials for " .. profile, "", "")
  hs.execute("aws sso login --profile " .. profile .. " && aws --profile " .. profile .. " s3 ls", true)
end

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "t", function() login("test") end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "p", function() login("prod") end)
