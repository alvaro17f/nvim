local M = {}

M.core = {
  arrows = {
    right = "",
    left = "",
    up = "",
    down = "",
  },
  bullet = "●",
  toggle = {
    enabled = " ",
    disabled = " ",
  },
}

M.debugger = {
  stopped = "󰁕 ",
  breakpoint = " ",
  breakpoint_condition = " ",
  breakpoint_rejected = " ",
  log_point = ".>",
}

M.diagnostics = {
  error = " ",
  warn = " ",
  hint = "󰠠 ", -- " "
  info = " ",
}

M.diff = {
  added = " ",
  modified = " ",
  removed = " ",
}

M.gitsigns = {
  v1 = {
    add = "▎",
    change = "▎",
    delete = "",
    topdelete = "",
    changedelete = "▎",
  },
  v2 = {
    add = "+",
    change = "~",
    delete = "_",
    topdelete = "‾",
    changedelete = "~",
  },
}

M.kind = {
  v1 = {
    Array = "  ",
    Boolean = " 󰨙 ",
    Class = " 󰯳 ",
    Codeium = " 󰘦 ",
    Color = " 󰰠 ",
    Control = "  ",
    Collapsed = " > ",
    Constant = " 󰯱 ",
    Constructor = "  ",
    Copilot = "  ",
    Enum = " 󰯹 ",
    EnumMember = "  ",
    Event = "  ",
    Field = "  ",
    File = "  ",
    Folder = "  ",
    Function = " 󰡱 ",
    Interface = " 󰰅 ",
    Key = "  ",
    Keyword = " 󱕴 ",
    Method = " 󰰑 ",
    Module = " 󰆼 ",
    Namespace = " 󰰔 ",
    Null = "  ",
    Number = " 󰰔 ",
    Object = " 󰲟 ",
    Operator = "  ",
    Package = " 󰰚 ",
    Property = " 󰲽 ",
    Reference = " 󰰠 ",
    Snippet = "  ",
    String = "  ",
    Struct = " 󰰣 ",
    TabNine = " 󰏚 ",
    Text = " 󱜥 ",
    TypeParameter = " 󰰦 ",
    Unit = " 󱜥 ",
    Value = "  ",
    Variable = " 󰫧 ",
  },
  v2 = {
    Array = "󰅪",
    Class = "",
    Color = "󰏘",
    Constant = "󰏿",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "󰜢",
    File = "󰈙",
    Folder = "󰉋",
    Function = "󰆧",
    Interface = "",
    Keyword = "󰌋",
    Method = "󰆧",
    Module = "",
    Operator = "󰆕",
    Property = "󰜢",
    Reference = "󰈇",
    Snippet = "",
    Struct = "",
    Text = "",
    TypeParameter = "",
    Unit = "",
    Value = "",
    Variable = "󰀫",
  },
}

M.lualine = {
  clock = " ",
  separator = {
    component = { left = "", right = "" },
    rounded = { left = "", right = "" },
    section = { left = "", right = "" },
  },
}

M.mason = {
  package_installed = "",
  package_pending = "",
  package_uninstalled = "",
}

M.snacks = {
  dashboard = {
    config = " ",
    file = " ",
    find = " ",
    grep = " ",
    quit = " ",
    recent = " ",
    restore = " ",
    update = " ",
  },
}

return M
