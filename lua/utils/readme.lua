local M = {}

local function extract_plugin_urls(content)
  local urls = {}
  for call in content:gmatch("vim%.pack%.add%b()") do
    for url in call:gmatch("['\"](https?://[^'\"]*)['\"]") do
      url = url:gsub("%.git$", "")
      if not vim.tbl_contains(urls, url) then
        table.insert(urls, url)
      end
    end
  end
  return urls
end

local function read_file(filepath)
  local fd = io.open(filepath, "r")
  if not fd then
    return
  end
  local content = fd:read("*a")
  fd:close()
  return content
end

local function get_plugin_dirs()
  local config = vim.fn.stdpath("config")
  local dirs = { config .. "/plugin/", config .. "/lua/plugins/" }

  local subdirs = vim.fn.readdir(dirs[2], function(name)
    return vim.fn.isdirectory(dirs[2] .. name) == 1
  end)

  if subdirs then
    for _, subdir in ipairs(subdirs) do
      table.insert(dirs, dirs[2] .. subdir .. "/")
    end
  end

  return dirs
end

local function collect_plugins()
  local plugins, seen = {}, {}

  for _, dir in ipairs(get_plugin_dirs()) do
    for _, file in ipairs(vim.fn.glob(dir .. "*.lua", false, true)) do
      local content = read_file(file)
      if content then
        local urls = extract_plugin_urls(content)
        for _, url in ipairs(urls) do
          if not seen[url] then
            local name = url:match(".*/(.*)$")
            if name then
              table.insert(plugins, ("- [%s](%s)"):format(name, url))
              seen[url] = true
            end
          end
        end
      end
    end
  end

  table.sort(plugins)
  return plugins
end

function M.generate_readme()
  local header = {
    '<div align="center">',
    '  <img src="assets/readme/neovim.png" alt="Neovim Logo" width="500"/>',
    "  ",
    "  # 🌌 Cosmic Neovim Configuration",
    "  ",
    "  *Where elegance meets efficiency in the vast expanse of code*",
    "  ",
    "  [![Neovim](https://img.shields.io/badge/Neovim-%2311AB00.svg?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)",
    "  [![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org/)",
    "  ",
    '  <p align="center">',
    '    <a href="#-features">Features</a> •',
    '    <a href="#-requirements">Requirements</a> •',
    '    <a href="#-flags">Flags</a> •',
    '    <a href="#-plugins">Plugins</a>',
    "  </p>",
    "</div>",
    "",
    "## 🌟 The Ultimate Coding Experience",
    "",
    "This configuration transforms Neovim into a **cosmic development environment** where every keystroke feels like navigating through the stars. With carefully curated plugins and intelligent defaults, it provides an unparalleled coding experience that balances beauty, performance, and functionality.",
    "",
    "## ✨ Features",
    "",
    "### 🎨 Visual Excellence",
    "Dive into a visually stunning coding environment with:",
    "- **Elegant Color Schemes**: Beautiful, carefully crafted themes with transparent backgrounds",
    "- **Dynamic Dashboard**: Custom ASCII art and intuitive startup interface",
    "- **Zen Mode**: Distraction-free coding environment for deep focus",
    "- **Smart Status Column**: Git integration and contextual information at a glance",
    "",
    "### 🧠 Artificial Intelligence Integration",
    "Experience the future of coding with AI-powered assistance:",
    "- **Contextual Code Generation**: AI that understands your codebase and generates relevant suggestions",
    "- **Intelligent Explanations**: Get detailed explanations for any code snippet or function",
    "- **Smart Completion**: AI-enhanced autocompletion that anticipates your needs",
    "",
    "### ⚡ Lightning Performance",
    "Navigate through code at the speed of thought:",
    "- **Native first**: Try to be as native as possible",
    "- **Instant Startup**: Sub-100ms load times for maximum productivity",
    "- **Memory Optimized**: Efficient resource management for large projects",
    "- **Asynchronous Operations**: Non-blocking UI for seamless interaction",
    "- **Lazy Loading**: Plugins load only when needed for optimal performance",
    "",
    "### 🛠️ Advanced Development Tools",
    "Supercharge your development workflow with professional-grade tools:",
    "- **Intelligent Language Support**: Full LSP integration with auto-installed language servers",
    "- **Enhanced Syntax Highlighting**: Tree-sitter powered highlighting for 100+ languages",
    "- **Integrated Debugging**: Full DAP support with beautiful debugging interface",
    "- **Version Control Integration**: Seamless Git integration with inline blame and diff previews",
    "- **Smart Session Management**: Auto-save and restore workspace across sessions",
    "- **Advanced Search & Replace**: Powerful text manipulation across entire projects",
    "- **Code Navigation**: Smart motion and tree-based navigation for complex codebases",
    "",
    "## 📦 Requirements",
    "",
    "- [Nerd Font](https://www.nerdfonts.com/)",
    "- [lazygit](https://github.com/jesseduffield/lazygit)",
    "- [ripgrep](https://github.com/BurntSushi/ripgrep)",
    "- [fd](https://github.com/sharkdp/fd)",
    "",
    "## 🏁 Flags",
    "",
    "This configuration features a powerful **Flags System** that allows you to customize your Neovim experience with simple boolean flags. Instead of manually editing configuration files, you can easily toggle features on and off through an intuitive interface.",
    "",
    "### Accessing Flags",
    "Press `<Leader>F` (by default, Leader is Space) to open the Flags interface where you can enable or disable various features:",
    "",
    "- **AI Integration** - Toggle AI-powered code assistance",
    "- **Debugger** - Enable/disable debugging capabilities",
    "- **File Explorer** - Choose between different file explorer implementations",
    "- **Testing Framework** - Enable/disable testing support",
    "- **And many more...**",
    "",
    "This system allows you to create a personalized development environment by enabling or disabling features based on your current project needs.",
    "",
    "## 🔌 Plugins",
    "",
  }

  local plugins = collect_plugins()
  local config = vim.fn.stdpath("config")
  local file = io.open(config .. "/README.md", "w")

  if file then
    file:write(table.concat(header, "\n"), "\n")
    file:write(table.concat(plugins, "\n"), "\n")
    file:close()
    vim.notify("README.md updated successfully", vim.log.levels.INFO)
  else
    vim.notify("Error opening README.md", vim.log.levels.ERROR)
  end
end

return M
