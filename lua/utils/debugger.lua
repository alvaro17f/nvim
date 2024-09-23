local M = {}

local function debugger_executable_path(debugger_name)
  return vim.fn.stdpath("data") .. "/mason/bin/" .. debugger_name
end

local get_workspace_root = function()
  local git = require("utils.git")
  if git.is_git_repo() then
    return git.get_git_root()
  else
    return vim.fn.getcwd()
  end
end

local function findDebugTarget(targetPrefix, depth)
  local dap = require("dap")
  local targets = {}
  for entry in vim.fs.dir(targetPrefix, { depth = depth }) do
    if vim.fn.executable(targetPrefix .. entry) == 1 then
      table.insert(targets, entry)
    end
  end
  if #targets == 1 then
    return targetPrefix .. targets[1]
  end
  if #targets == 0 then
    vim.print("Cannot find debug target")
    return dap.ABORT
  end
  return coroutine.create(function(coro)
    vim.ui.select(targets, {
      prompt = "Select target to debug: ",
    }, function(choice)
      if choice == nil then
        coroutine.resume(coro, dap.ABORT)
      else
        coroutine.resume(coro, targetPrefix .. choice)
      end
    end)
  end)
end

local function find_program(lang)
  local handlers = {
    zig = function()
      vim.fn.delete("zig-out", "rf")
      vim.fn.system({ "zig", "build", "-Doptimize=Debug" })
      return findDebugTarget(get_workspace_root() .. "/zig-out/bin/", 2)
    end,
  }

  return handlers[lang] or "${file}"
end

local function generate_debugger_config(lang, debugger, additional_configs)
  local base_config = {
    {
      type = debugger,
      name = "Debug",
      request = "launch",
      program = find_program(lang),
      cwd = get_workspace_root,
      stopOnEntry = false,
    },
  }

  if additional_configs then
    for _, config in ipairs(additional_configs) do
      config.type = debugger
      table.insert(base_config, config)
    end
  end

  return base_config
end

M.ADAPTERS = {
  delve = {
    type = "server",
    port = "${port}",
    executable = {
      command = debugger_executable_path("dlv"),
      args = { "dap", "-l", "127.0.0.1:${port}" },
      detached = vim.fn.has("win32") == 0,
    },
  },
  codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = debugger_executable_path("codelldb"),
      args = { "--port", "${port}" },
      detached = vim.fn.has("win32") == 0,
    },
  },
}

M.DEBUGGERS = {}
for key, _ in pairs(M.ADAPTERS) do
  table.insert(M.DEBUGGERS, key)
end

M.CONFIGURATIONS = {
  c = generate_debugger_config("c", "codelldb"),
  cpp = generate_debugger_config("cpp", "codelldb"),
  go = generate_debugger_config("go", "delve", {
    {
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    {
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  }),
  rust = generate_debugger_config("rust", "codelldb"),
  zig = generate_debugger_config("zig", "codelldb"),
}

return M
