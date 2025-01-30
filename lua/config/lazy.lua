------------------------------------
-- LAZY
------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
------------------------------------
-- PLUGINS
------------------------------------

require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  rocks = { enabled = false }, -- disable luarocks
  ui = {
    custom_keys = {
      ["<C-r>"] = {
        function(_)
          local plugins = require("lazy.core.config").plugins
          local file_content = {
            "<h1>",
            '  <img src="https://raw.githubusercontent.com/neovim/neovim.github.io/master/logos/neovim-logo-300x87.png" alt="Neovim">',
            "</h1>",
            "",
            '<a href="https://dotfyle.com/alvaro17f/nvim"><img src="https://dotfyle.com/alvaro17f/nvim/badges/plugins?style=flat" /></a>',
            '<a href="https://dotfyle.com/alvaro17f/nvim"><img src="https://dotfyle.com/alvaro17f/nvim/badges/leaderkey?style=flat" /></a>',
            '<a href="https://dotfyle.com/alvaro17f/nvim"><img src="https://dotfyle.com/alvaro17f/nvim/badges/plugin-manager?style=flat" /></a>',
            "",
            "![image](assets/readme/neovim.png)",
            "",
            "## ⚡️ Requirements",
            "",
            "- [Nerd Font](https://www.nerdfonts.com/)",
            "- [lazygit](https://github.com/jesseduffield/lazygit)",
            "- [ripgrep](https://github.com/BurntSushi/ripgrep)",
            "- [fd](https://github.com/sharkdp/fd)",
            "",
            "## 💤 Plugin manager",
            "",
            "- [lazy.nvim](https://github.com/folke/lazy.nvim)",
            "",
            "## 🔌 Plugins",
            "",
          }
          local plugins_md = {}
          for plugin, spec in pairs(plugins) do
            if spec.url then
              table.insert(plugins_md, ("- [%s](%s)"):format(plugin, spec.url:gsub("%.git$", "")))
            end
          end
          table.sort(plugins_md, function(a, b)
            return a:lower() < b:lower()
          end)

          for _, p in ipairs(plugins_md) do
            table.insert(file_content, p)
          end

          table.insert(file_content, "")

          local file, err = io.open(vim.fn.stdpath("config") .. "/README.md", "w")
          if not file then
            error(err)
          end
          file:write(table.concat(file_content, "\n"))
          file:close()
          vim.notify("README.md succesfully generated", vim.log.levels.INFO, {})
        end,
        desc = "Generate README.md file",
      },
    },
  },
})
