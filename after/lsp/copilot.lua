---@type vim.lsp.Config
return {
  on_attach = function(client, bufnr)
    if not vim.lsp.inline_completion.is_enabled({ client_id = client.id, bufnr = bufnr }) then
      client:stop()
    end
  end,
  settings = {
    telemetry = {
      telemetryLevel = "off",
    },
  },
}
