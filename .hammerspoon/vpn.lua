local home = os.getenv("HOME")

local test_ip = "10.2.0.2"
local prod_ip = "172.31.0.2"

local ip_names = { [test_ip] = "test", [prod_ip] = "prod" }

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
  StandardErrorPath = home .. "/.bin/log/saml-server.log",
  StandardOutPath = home .. "/.bin/log/saml-server.log"
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
  StandardErrorPath = home .. "/.bin/log/dns-refresh.log",
  StandardOutPath = home .. "/.bin/log/dns-refresh.log"
})

add_job(test_job_id, {
  WorkingDirectory = home .. "/.bin",
  EnvironmentVariables = {
    VPN_ENV = "test",
    VPN_CONF = home .. "/.config/test.ovpn",
    VPN_HOST = "cvpn-endpoint-01353e4930b3f0ca1.prod.clientvpn.us-east-1.amazonaws.com",
    PATH = os.getenv("PATH") .. ":" .. home .. "/.bin",
  },
  ProgramArguments = { home .. "/.bin/vpn" },
  StandardErrorPath = home .. "/.bin/log/test-vpn.log",
  StandardOutPath = home .. "/.bin/log/test-vpn.log"
})

add_job(prod_job_id, {
  WorkingDirectory = home .. "/.bin",
  EnvironmentVariables = {
    VPN_ENV = "prod",
    VPN_CONF = home .. "/.config/prod.ovpn",
    VPN_HOST = "cvpn-endpoint-022d7eb676972a623.prod.clientvpn.us-east-1.amazonaws.com",
    PATH = os.getenv("PATH") .. ":" .. home .. "/.bin",
  },
  ProgramArguments = { home .. "/.bin/vpn" },
  StandardErrorPath = home .. "/.bin/log/prod-vpn.log",
  StandardOutPath = home .. "/.bin/log/prod-vpn.log"
})

local function toggle_vpn(job_id, env)
  local toggle = is_running(job_id) and "stop" or "start"
  hs.notify.show(toggle .. (toggle == "stop" and "ping " or "ing ") .. env, "", "")
  local command = "launchctl " .. toggle .. " " .. job_id
  os.execute(command)
end

local function update_vpn_status(menubar, ip)
  local is_connected = os.execute("nc -G2 -w1 -z " .. ip .. " 53")
  menubar:setIcon(home .. "/.hammerspoon/images/vpn-" .. (is_connected and "on" or "off") .. ".pdf")
  menubar:setTooltip((is_connected and "Connected" or "Not connected") .. " to " .. ip_names[ip])
end

TEST_VPN_MENU = hs.menubar.new()
TEST_VPN_MENU:setClickCallback(function() toggle_vpn(test_job_id, "test") end)
update_vpn_status(TEST_VPN_MENU, test_ip)

PROD_VPN_MENU = hs.menubar.new()
PROD_VPN_MENU:setClickCallback(function() toggle_vpn(prod_job_id, "prod") end)
update_vpn_status(PROD_VPN_MENU, prod_ip)

local function maybe_update_vpn_status(files)
  for _, file in pairs(files) do
     if (file:match("test.connected")) then update_vpn_status(TEST_VPN_MENU, test_ip) end
     if (file:match("prod.connected")) then update_vpn_status(PROD_VPN_MENU, prod_ip) end
  end
end

LOG_PATH_WATCHER = hs.pathwatcher.new(home .. "/.bin/log", maybe_update_vpn_status):start()
