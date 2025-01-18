-- TODO: configure this debugger
return {
  "nvim-dap",
  dependencies = { "mxsdev/nvim-dap-vscode-js" },
  opts = function()
    local dap = require("dap")

    require("dap-vscode-js").setup({
      debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
    })

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }

    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }

    local languages = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
    }

    for _, lang in ipairs(languages) do
      local cwd = vim.fs.root(0, "package.json") or vim.fn.getcwd()

      dap.configurations[lang] = {
        {
          name = "Launch project",
          type = "pwa-node",
          request = "launch",
          cwd = cwd,
          runtimeExecutable = "node",
          runtimeArgs = { "debug" },
        },
        {
          name = "Launch file",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = cwd,
        },
        {
          name = "Attach",
          type = "pwa-node",
          request = "attach",
          port = 9229,
          cwd = cwd,
        },
        {
          name = "Attach process",
          type = "pwa-node",
          request = "attach",
          processId = require("dap.utils").pick_process,
          cwd = cwd,
        },
        {
          name = "Launch Chrome",
          type = "pwa-chrome",
          request = "launch",
          runtimeExecutable = "/usr/bin/google-chrome-stable",
          userDataDir = false,
          webRoot = cwd,
        },
        {
          name = "attach chrome",
          type = "pwa-chrome",
          request = "attach",
          port = 9222,
          webroot = cwd,
        },
      }
    end
  end,
}
