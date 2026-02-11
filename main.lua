return {
  entry = function()
    local input, event = ya.input({
      title = "Create:",
      pos = { "center", w = 50 },
    })

    if event ~= 1 then
      return
    end

    if not input or input == "" then
      ya.notify({
        title = "Error",
        content = "Folder or file name cannot be empty",
        level = "error",
        timeout = 3,
      })
      return
    end

    local timestamp = tostring(os.time())
    local filename = timestamp .. "-" .. input

    local url, err = fs.cwd()
    if err then
      ya.notify({
        title = "Error",
        content = "Failed to get current directory: " .. tostring(err),
        level = "error",
        timeout = 5,
      })
      return
    end

    local path = url:join(filename)

    local ok, create_err = fs.create("dir_all", path)
    if not ok or create_err then
      ya.notify({
        title = "Error",
        content = "Failed to create directory or file: " .. tostring(create_err or "unknown error"),
        level = "error",
        timeout = 5,
      })
      return
    end
  end,
}
