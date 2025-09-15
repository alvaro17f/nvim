_G.Utils.snacks = {
  dashboard = {},
}

local logos_path = vim.fn.stdpath("config") .. "/assets/logos/"

Utils.snacks.dashboard.get_logo = function()
  if Flags.logo == false then
    Flags.logo = "neovim"
  end

  local success, logo = pcall(vim.fn.readfile, logos_path .. Flags.logo)
  return success and table.concat(logo, "\n") or ""
end
