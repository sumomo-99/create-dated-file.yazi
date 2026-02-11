# create-dated-file.yazi

A [Yazi](https://github.com/sxyazi/yazi) plugin that creates a new directory prefixed with the current Unix timestamp.

## Installation

```bash
ya pkg add sumomo-99/create-dated-file
```

## Features

- Prompts the user for a name.
- Creates a directory in the current working directory with the format: `<timestamp>-<input_name>`.
- Useful for creating unique, chronologically sorted folders.

## Usage

1. Trigger the plugin.
2. Enter the desired name in the input prompt (e.g., `my-project`).
3. The plugin creates a directory like `1739268000-my-project`.

## Configuration

Add the following to your `keymap.toml` to bind the plugin to a key (e.g., `c`, `d`):

```toml
[[mgr.prepend_keymap]]
on = [ "c", "d" ]
run = "plugin create-dated-file"
desc = "Create file with unix timesptamp"
```
