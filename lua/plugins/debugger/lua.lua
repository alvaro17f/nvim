-- TODO: configure this debugger
return {
  "nvim-dap",
  opts = function()
    local dap = require("dap")
    dap.configurations.lua = {
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
        host = function()
          local value = vim.fn.input("Host [127.0.0.1]: ")
          if value ~= "" then
            return value
          end
          return "127.0.0.1"
        end,
        port = function()
          local val = tonumber(vim.fn.input("Port: ", "54321"))
          assert(val, "Please provide a port number")
          return val
        end,
      },
    }

    dap.adapters.nlua = function(callback, config)
      callback({
        type = "server",
        ---@diagnostic disable-next-line: undefined-field
        host = config.host,
        ---@diagnostic disable-next-line: undefined-field
        port = config.port,
      })
    end
  end,
}
