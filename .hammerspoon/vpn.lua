local function getStatusOf(ip)
  local _, isConnected = hs.execute("nc -G1 -w1 -z " .. ip .. " 53")
  if isConnected then return "✅" else return "❌" end
end

local function showStatus()
  hs.alert(getStatusOf("10.2.0.2") .. " - test vpn", nil, nil, 3)
  hs.alert(getStatusOf("172.31.0.2") .. " - prod vpn", nil, nil, 3)
end

-- testVpnMenu = hs.menubar.new(true)
-- testVpnMenu.setIcon(hs.image.imageFromName(hs.image.systemImageNames.Info))

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "V", showStatus)


caffeine = hs.menubar.new()

function setCaffeineDisplay(state)
  if state then
    caffeine:setTitle("AWAKE")
  else
    caffeine:setTitle("SLEEPY")
  end
end

function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
  caffeine:setClickCallback(caffeineClicked)
  setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
