hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "t", function()
  hs.execute("aws sso login --profile test && aws --profile test s3 ls", true)
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "p", function()
  hs.execute("aws sso login --profile prod && aws --profile prod s3 ls", true)
end)
