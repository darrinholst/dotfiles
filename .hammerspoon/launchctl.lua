local home = os.getenv("HOME")

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

return {
  add_job = add_job,
  is_running = is_running
}
