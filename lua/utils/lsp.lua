local M = {}

local function get_most_severe_diagnostics(diagnostics)
  if not diagnostics then
    return {}
  end

  local most_severe = {}
  for _, diagnostic in pairs(diagnostics) do
    local max_severity_diagnostic = most_severe[diagnostic.lnum]

    if not max_severity_diagnostic or diagnostic.severity < max_severity_diagnostic.severity then
      most_severe[diagnostic.lnum] = diagnostic
    end
  end

  return vim.tbl_values(most_severe)
end

function M.override_diagnostic_signs_handler()
  local namespace = vim.api.nvim_create_namespace("severe-diagnostics")
  local original_signs_handler = vim.diagnostic.handlers.signs

  vim.diagnostic.handlers.signs = {
    show = function(_, bufnr, _, opts)
      local diagnostics = vim.diagnostic.get(bufnr)
      local filtered_diagnostics = get_most_severe_diagnostics(diagnostics)

      original_signs_handler.show(namespace, bufnr, filtered_diagnostics, opts)
    end,

    hide = function(_, bufnr)
      original_signs_handler.hide(namespace, bufnr)
    end,
  }
end

return M
