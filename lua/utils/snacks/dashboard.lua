_G.Utils = _G.Utils or {}
_G.Utils.snacks = _G.Utils.snacks or {}
_G.Utils.snacks.dashboard = _G.Utils.snacks.dashboard or {}

local logos_path = vim.fn.stdpath("config") .. "/assets/logos/"

Utils.snacks.dashboard.get_logo = function()
  if Flags.logo == false then
    Flags.logo = "neovim"
  end

  local success, logo = pcall(vim.fn.readfile, logos_path .. Flags.logo)
  return success and table.concat(logo, "\n") or ""
end
