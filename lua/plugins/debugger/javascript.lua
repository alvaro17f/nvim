return {
  "nvim-dap",
  opts = function()
    local dap = require("dap")
    local git = require("utils.git")
    local debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
    local cwd = vim.fs.root(0, "package.json") or git.get_workspace_root()

    if not dap.adapters["pwa-node"] then
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            debugger_path,
            "${port}",
          },
        },
      }
    end
    if not dap.adapters["node"] then
      dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
          config.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    local vscode = require("dap.ext.vscode")
    vscode.type_to_filetypes["node"] = js_filetypes
    vscode.type_to_filetypes["pwa-node"] = js_filetypes

    for _, language in ipairs(js_filetypes) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
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
            processId = require("dap.utils").pick_process,
            cwd = cwd,
          },
          {
            name = "Launch [Browser]",
            type = "pwa-chrome",
            request = "launch",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:3000",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
            webRoot = cwd,
          },
          {
            name = "Attach [Browser]",
            type = "pwa-chrome",
            request = "attach",
            port = 9222,
            webroot = cwd,
          },
        }
      end
    end
  end,
}
