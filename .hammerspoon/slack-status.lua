-- Hammerspoon script to automatically update your slack status when in zoom
--
-- To use:
--
-- * Install and set up the slack-status script (make sure it's in your path)
-- * Run slack-status setup
-- * Ensure there is a 'zoom' preset (one is created by default during setup)
-- * Install hammerspoon (brew install hammerspoon) if you don't have it already.
-- * Copy this file to ~/.hammerspoon
-- * Add the following line to ~/.hammerspoon/init.lua
--      require("slack-status")
-- * If it's a fresh `brew install` of Hammerspoon, start it and make sure accessibility is enabled

local check_interval = 15 -- How often to check if you're in zoom, in seconds
local logger = hs.logger.new('slack-status', 'debug')

local function update_status(status)
  logger.i("Updating status to " .. status)
  hs.execute("slack-status " .. status, true)
end

local function is_zooming()
  local a = hs.application.find("zoom.us")

  if a ~= nil then
    local m = a:findMenuItem("Join Meeting...")
    return m ~= nil and not m["enabled"] -- Start meeting menu item exists and is disabled
  else
    return false -- Zoom isn't running
  end
end

local function buildSpotifyStatus()
  return hs.spotify.getCurrentArtist()
end

local we_set_zoom = false
local spotify_status = ""

timer = hs.timer.doEvery(check_interval, function()
  if (hs.spotify.isPlaying()) then
    logger.i("current: " .. spotify_status, "new: " .. buildSpotifyStatus(), spotify_status ~= buildSpotifyStatus())
    if (spotify_status ~= buildSpotifyStatus()) then
      spotify_status = buildSpotifyStatus()
      update_status("spotify " .. spotify_status)
    end
  elseif (spotify_status ~= "") then
    spotify_status = ""
    update_status("none")
  end

  if (is_zooming()) then
    we_set_zoom = true
    update_status("zoom")
  elseif (we_set_zoom) then
    we_set_zoom = false
    update_status("none")
  end

end)

timer:start()
