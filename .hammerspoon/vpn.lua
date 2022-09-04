local function getStatusOf(ip)
  local _, isConnected = hs.execute("nc -G1 -w1 -z " .. ip .. " 53")
  if isConnected then return "✅" else return "❌" end
end

local function showStatus()
  hs.alert(getStatusOf("10.2.0.2") .. " - test vpn", nil, nil, 3)
  hs.alert(getStatusOf("172.31.0.2") .. " - prod vpn", nil, nil, 3)
end

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "V", showStatus)
local home = hs.fs.pathToAbsolute("~")

local function add_job(job_id, job_plist)
  local job_plist_location = home .. "/Library/LaunchAgents/" .. job_id .. ".plist"
  job_plist.Label = job_id
  hs.plist.write(job_plist_location, job_plist)
  hs.execute("launchctl unload " .. job_plist_location)
  hs.execute("launchctl load " .. job_plist_location)
  local uid = hs.execute("id -u")
  print(hs.execute("launchctl print gui/" .. string.gsub(uid, "\n", "") .. "/" .. job_id))
end

--
-- AWS has decided not to support oss vpn clients with their
-- sso authentiction. This server is needed to circumvent that.
-- https://github.com/samm-git/aws-vpn-client
--
add_job("com.darrinholst.saml-server", {
  KeepAlive = { SuccessfulExit = false },
  WorkingDirectory = home .. "/.bin",
  ProgramArguments = { home .. "/.bin/saml-server" },
  StandardErrorPath = home .. "/.bin/saml-server.log",
  StandardOutPath = home .. "/.bin/saml-server.log"
})

--
-- We have to resolve our own host names for test and prod
-- since DNS doesn't do fallback. And I like to use cloudflare
-- DNS anyway.
--
add_job("com.darrinholst.dns-resolver", {
  StartInterval = 60,
  WorkingDirectory = home .. "/.bin",
  ProgramArguments = { home .. "/.bin/dns-refresh" },
  StandardErrorPath = home .. "/.bin/dns-refresh.log",
  StandardOutPath = home .. "/.bin/dns-refresh.log"
})


-- caffeine = hs.menubar.new()

-- function setCaffeineDisplay(state)
--   if state then
--     caffeine:setTitle("🔴")
--   else
--     caffeine:setTitle("🎾")
--   end
-- end

-- function caffeineClicked()
--   setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
-- end

-- if caffeine then
--   caffeine:setClickCallback(caffeineClicked)
--   setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
-- end
