local M = {}

local function extract_plugin_urls(content)
  local urls = {}
  for line in content:gmatch("[^\r\n]+") do
    local url = line:match("[\"'](https://github.com/[^\"']*)[\"']")
      or line:match("[\"'](https?://github.com/[^\"']*)[\"']")

    if url and url:match("github.com") then
      url = url:gsub("%.git$", ""):gsub("[\",']*", "")
      table.insert(urls, url)
    end
  end
  return urls
end

function M.generate_readme()
  local file_content = {
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

  local plugins_md = {}
  local seen_plugins = {}

  local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/plugin/*.lua", false, true)
  for _, file in ipairs(plugin_files) do
    local fd = io.open(file, "r")
    if fd then
      local content = fd:read("*all")
      fd:close()

      local urls = extract_plugin_urls(content)
      for _, url in ipairs(urls) do
        if not seen_plugins[url] then
          local plugin_name = url:match(".*/(.*)$")
          if plugin_name then
            plugin_name = plugin_name:gsub("%.git$", "")
            table.insert(plugins_md, ("- [%s](%s)"):format(plugin_name, url))
            seen_plugins[url] = true
          end
        end
      end
    end
  end

  local plugins_base_dir = vim.fn.stdpath("config") .. "/lua/plugins/"
  local plugin_dirs = { plugins_base_dir }
  local subdirs = vim.fn.readdir(plugins_base_dir, function(name)
    return vim.fn.isdirectory(plugins_base_dir .. name) == 1
  end)

  for _, subdir in ipairs(subdirs) do
    table.insert(plugin_dirs, plugins_base_dir .. subdir .. "/")
  end

  for _, dir in ipairs(plugin_dirs) do
    local files = vim.fn.glob(dir .. "*.lua", false, true)
    for _, file in ipairs(files) do
      local fd = io.open(file, "r")
      if fd then
        local content = fd:read("*all")
        fd:close()
        local urls = extract_plugin_urls(content)
        for _, url in ipairs(urls) do
          if not seen_plugins[url] then
            local plugin_name = url:match(".*/(.*)$")
            if plugin_name then
              plugin_name = plugin_name:gsub("%.git$", "")
              table.insert(plugins_md, ("- [%s](%s)"):format(plugin_name, url))
              seen_plugins[url] = true
            end
          end
        end
      end
    end
  end

  table.sort(plugins_md, function(a, b)
    return a:lower() < b:lower()
  end)

  for _, p in ipairs(plugins_md) do
    table.insert(file_content, p)
  end

  table.insert(file_content, "")

  local readme_path = vim.fn.stdpath("config") .. "/README.md"
  local file, err = io.open(readme_path, "w")
  if not file then
    vim.notify("Error opening README.md: " .. err, vim.log.levels.ERROR, {})
    return
  end
  file:write(table.concat(file_content, "\n"))
  file:close()
  vim.notify("README.md updated", vim.log.levels.INFO, {})
end

return M
