local home = os.getenv("HOME")

local test_ip = "10.2.0.2"
local prod_ip = "172.31.0.2"

local test_job_id = "com.darrinholst.test-vpn"
local prod_job_id = "com.darrinholst.prod-vpn"

local function is_running(job_id)
  return os.execute("launchctl list | grep -e '^\\d\\+.*" .. job_id .. "'")
end

local function add_job(job_id, job_plist)
  local job_plist_location = home .. "/Library/LaunchAgents/" .. job_id .. ".plist"
  job_plist.Label = job_id
  hs.plist.write(job_plist_location, job_plist)

  if (not is_running(job_id)) then
    os.execute("launchctl unload " .. job_plist_location)
    os.execute("launchctl load " .. job_plist_location)
  end
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

add_job(test_job_id, {
  WorkingDirectory = home .. "/.bin",
  EnvironmentVariables = {
    VPN_CONF = home .. "/.config/test.ovpn",
    VPN_HOST = "cvpn-endpoint-01353e4930b3f0ca1.prod.clientvpn.us-east-1.amazonaws.com",
    PATH = os.getenv("PATH") .. ":" .. home .. "/.bin",
  },
  ProgramArguments = { home .. "/.bin/vpn" },
  StandardErrorPath = home .. "/.bin/test-vpn.log",
  StandardOutPath = home .. "/.bin/test-vpn.log"
})

add_job(prod_job_id, {
  WorkingDirectory = home .. "/.bin",
  EnvironmentVariables = {
    VPN_CONF = home .. "/.config/prod.ovpn",
    VPN_HOST = "cvpn-endpoint-022d7eb676972a623.prod.clientvpn.us-east-1.amazonaws.com",
    PATH = os.getenv("PATH") .. ":" .. home .. "/.bin",
  },
  ProgramArguments = { home .. "/.bin/vpn" },
  StandardErrorPath = home .. "/.bin/prod-vpn.log",
  StandardOutPath = home .. "/.bin/prod-vpn.log"
})

local function is_connected(ip)
  return os.execute("nc -G1 -w1 -z " .. ip .. " 53")
end

local function toggle_vpn(job_id)
  local toggle = is_running(job_id) and "stop" or "start"
  os.execute("launchctl " .. toggle .. " " .. test_job_id)
end

TEST_VPN_MENU = hs.menubar.new()
TEST_VPN_MENU:setClickCallback(function() toggle_vpn(test_job_id) end)

local function update_vpn_status(menubar, ip)
  menubar:setTitle(is_connected(ip) and "🟢" or "🔴")
end

TEST_VPN_TIMER = hs.timer.doEvery(15, function() update_vpn_status(TEST_VPN_MENU, test_ip) end)
