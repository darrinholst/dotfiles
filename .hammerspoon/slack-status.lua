SLACK_TIMER = nil -- keep global so it's not garbage collected

local active_interval = 15 -- How often to check when not in do not disturb
local dnd_interval = 3600 -- How often to check when in do not disturb
local state = {}
local main = nil

local function update_status(emoji, text)
  emoji = emoji or ""
  text = text or ""
  local profile = hs.json.encode({ status_emoji = emoji, status_text = text, status_expiration = 0 })
  print("Updating slack profile to " .. hs.inspect(profile))

  -- TODO: convert to hs.http.asyncPost
  hs.execute("source ~/.envrc && curl -s --data token=$SLACK_TOKEN --data-urlencode profile='" ..
    profile .. "' https://slack.com/api/users.profile.set")
end

local function buildSpotifyStatus()
  return hs.spotify.getCurrentArtist()
end

local function set_spotify_status()
  if (hs.spotify.isPlaying()) then
    if (state.spotifying ~= buildSpotifyStatus()) then
      state.spotifying = buildSpotifyStatus()
      update_status(":spotify:", state.spotifying)
    end
  elseif (state.spotifying ~= "") then
    state.spotifying = ""
    update_status()
  end
end

local function is_zooming()
  local app = hs.application.find("zoom.us")

  if app ~= nil then
    local m = app:findMenuItem("Join Meeting...")
    return m ~= nil and not m["enabled"] -- Start meeting menu item exists and is disabled
  else
    return false -- Zoom isn't running
  end
end

local function set_zoom_status()
  if (is_zooming()) then
    if (not state.zooming) then
      update_status(":zoom:", "Zooming")
      state.zooming = true
    end
  elseif (state.zooming) then
    state.zooming = false
    update_status()
  end
end

local function set_afk_status()
  if (hs.caffeinate.sessionProperties().CGSSessionScreenIsLocked) then
    if (not state.afking) then
      update_status(":away:", "At the tone, please leave your name and a detailed message.")
      state.afking = true
    end
  elseif (state.afking) then
    state.afking = false
    update_status()
  end
end

local function is_dnding()
  -- TODO: convert to hs.http.asyncGet
  local raw, status = hs.execute("source ~/.envrc && curl -s --data token=$SLACK_TOKEN https://slack.com/api/dnd.info")

  if (status) then
    local profile = hs.json.decode(raw)
    return os.time() > profile.next_dnd_start_ts and os.time() < profile.next_dnd_end_ts
  end
end

local function set_dnd_status()
  if (is_dnding()) then
    if (not state.dnding) then
      update_status()
      state.dnding = true
      SLACK_TIMER:stop()
      SLACK_TIMER = hs.timer.new(dnd_interval, main):start()
    end

    return true
  elseif (state.dnding) then
    SLACK_TIMER:stop()
    SLACK_TIMER = hs.timer.new(active_interval, main):start()
    state.dnding = false
  end
end

main = function()
  -- If we're in do not disturb nothing else matters
  if (set_dnd_status()) then return end

  -- Ordered by priority, i.e. if we're afk then that will override
  -- zoom and spotify. If we're zooming hopefully we're not listening
  -- to music. Or we're at least going to make people think that.
  set_spotify_status()
  set_zoom_status()
  set_afk_status()
end

SLACK_TIMER = hs.timer.new(active_interval, main)
SLACK_TIMER:start()
main()
