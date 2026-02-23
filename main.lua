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
    local input_url = Url(input)

    local base_name = input_url.name
    local dir_part_url = input_url.parent

    local timestamped_base_name = timestamp .. "-" .. base_name

    local final_relative_url
    if dir_part_url and dir_part_url.path ~= "" then -- Check if there's a directory part
      final_relative_url = dir_part_url:join(timestamped_base_name)
    else
      final_relative_url = Url(timestamped_base_name)
    end

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

    local path = url:join(final_relative_url)
    local parent_dir = path.parent

    -- Create parent directories recursively
    local ok_dir, create_err_dir = fs.create("dir_all", parent_dir)
    if not ok_dir or create_err_dir then
      ya.notify({
        title = "Error",
        content = "Failed to create parent directories: " .. tostring(create_err_dir or "unknown error"),
        level = "error",
        timeout = 5,
      })
      return
    end

    -- Create empty file
    local ok_file, create_err_file = fs.write(path, "")
    if not ok_file or create_err_file then
      ya.notify({
        title = "Error",
        content = "Failed to create file: " .. tostring(create_err_file or "unknown error"),
        level = "error",
        timeout = 5,
      })
      return
    end
  end,
}
