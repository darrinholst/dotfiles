local home = os.getenv("HOME")

local test_ip = "10.2.0.2"

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

local function hours_since(time)
  return string.format("%.1f", (os.time() - time) / 3600) .. "h"
end

local function minutes_until(time)
  return string.format("%.0f", (time - os.time()) / 60) .. "m"
end

local function is_aws_authed()
  local ssoConfig = hs.json.read(home .. "/.aws/sso/cache/66d08d7b7f546523e4f0bf784351e9a2fa5bcd88.json")
  if (not ssoConfig or not ssoConfig.expiresAt) then return false end

  local currentTime = os.date("*t")
  local iso8601 = "(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)"
  local year, month, day, hour, min, sec = ssoConfig.expiresAt:match(iso8601)
  local expiresAt = os.time({ year = year, month = month, day = day, hour = hour - (currentTime.isdst and 5 or 6),
    min = min, sec = sec })

  return os.time() < expiresAt, minutes_until(expiresAt)
end

local function aws_login()
  hs.notify.show("SSOing to AWS", "", "")
  hs.execute("aws sso login --profile test && rm -rf ~/.aws/cli/cache && aws --profile test s3 ls && aws --profile prod s3 ls"
    , true)
end

MENU = hs.menubar.new()
MENU:setIcon(home .. "/.hammerspoon/images/vpn-off.pdf")
MENU:setMenu(function()
  local aws_authed, hours_remaining = is_aws_authed()
  local test_connected = io.open(home .. "/.bin/log/test.connected", "r")
  local prod_connected = io.open(home .. "/.bin/log/prod.connected", "r")

  return {
    {
      title = "Test VPN" .. (test_connected and (" (" .. hours_since(test_connected:read()) .. ")") or ""),
      checked = test_connected and true or false,
      fn = function() toggle_vpn(test_job_id, "test") end
    },
    {
      title = "Prod VPN" .. (prod_connected and (" (" .. hours_since(prod_connected:read()) .. ")") or ""),
      checked = prod_connected and true or false,
      fn = function() toggle_vpn(prod_job_id, "prod") end
    },
    {
      title = "-",
    },
    {
      title = "AWS SSO" .. (aws_authed and (" (" .. hours_remaining .. ")") or ""),
      checked = aws_authed,
      fn = function() aws_login() end,
    },
  }
end)

local function update_icon()
  local is_connected = os.execute("nc -G2 -w1 -z " .. test_ip .. " 53")
  MENU:setIcon(home .. "/.hammerspoon/images/vpn-" .. (is_connected and "on" or "off") .. ".pdf")
end

update_icon()

local function maybe_update_vpn_status(files)
  for _, file in pairs(files) do
    if (file:match(".connected")) then update_icon() end
  end
end

LOG_PATH_WATCHER = hs.pathwatcher.new(home .. "/.bin/log", maybe_update_vpn_status):start()

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "v", function() toggle_vpn(test_job_id, "test") end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "a", function() aws_login() end)
