---@diagnostic disable: missing-fields

if vim.g.tests == false then
  return {}
end

local function count_failed_results(results, tree)
  local failed = 0
  for pos_id, result in pairs(results) do
    if result.status == "failed" and tree:get_key(pos_id) then
      failed = failed + 1
    end
  end
  return failed
end

local function refresh_trouble(failed)
  local trouble = require("trouble")
  if trouble.is_open() then
    trouble.refresh()
    if failed == 0 then
      trouble.close()
    end
  end
end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "nvim-neotest/nvim-nio" },
      { "nvim-neotest/neotest-plenary" },
      { "nvim-neotest/neotest-jest" },
      { "marilari88/neotest-vitest" },
    },
    -- stylua: ignore
    keys = {
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
      { "<leader>tT", function() require("neotest").run.run(require("utils.git").get_workspace_root()) end, desc = "Run All Test Files (Neotest)" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      require("neotest").setup({
        adapters = {
          require("neotest-plenary"),
          require("neotest-jest"),
          require("neotest-vitest"),
        },
        status = { virtual_text = true },
        output = { open_on_run = false },
        quickfix = {
          open = function()
            require("trouble").open({
              mode = "quickfix",
              focus = true,
              auto_preview = false,
            })
          end,
        },
        consumers = {
          trouble = function(client)
            client.listeners.results = function(adapter_id, results, partial)
              if partial then
                return
              end

              local tree = assert(client:get_position(nil, { adapter = adapter_id }))
              local failed = count_failed_results(results, tree)

              vim.schedule(function()
                refresh_trouble(failed)
              end)
            end
            return {}
          end,
        },
      })
    end,
  },
}