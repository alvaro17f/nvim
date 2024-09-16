local function capitalize_first_letter(str)
  return str:sub(1, 1):upper() .. str:sub(2)
end

local function setup_flag_commands()
  local flags = require("utils.flags")

  local function create_flag_commands(flag)
    vim.api.nvim_create_user_command("Flag" .. capitalize_first_letter(flag) .. "Enable", function()
      flags.set_flags(flag, true)
      vim.notify(flag .. " enabled", vim.log.levels.INFO)
    end, {})

    vim.api.nvim_create_user_command("Flag" .. capitalize_first_letter(flag) .. "Disable", function()
      flags.set_flags(flag, false)
      vim.notify(flag .. " disabled", vim.log.levels.INFO)
    end, {})
  end

  local all_flags = flags.get_all_flags()
  for flag, _ in pairs(all_flags) do
    create_flag_commands(flag)
  end
end

setup_flag_commands()
