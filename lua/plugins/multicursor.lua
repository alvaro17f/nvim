return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "v" }, "<a-k>", function()
      mc.lineAddCursor(-1)
    end)
    set({ "n", "v" }, "<a-j>", function()
      mc.lineAddCursor(1)
    end)
    set({ "n", "v" }, "<a-s-k>", function()
      mc.lineSkipCursor(-1)
    end)
    set({ "n", "v" }, "<a-s-j>", function()
      mc.lineSkipCursor(1)
    end)

    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "v" }, "<a-n>", function()
      mc.matchAddCursor(1)
    end)
    set({ "n", "v" }, "<a-p>", function()
      mc.matchAddCursor(-1)
    end)
    set({ "n", "v" }, "<a-s>", function()
      mc.matchSkipCursor(1)
    end)
    set({ "n", "v" }, "<a-s-p>", function()
      mc.matchSkipCursor(-1)
    end)

    -- Add all matches in the document
    set({ "n", "v" }, "<a-a>", mc.matchAllAddCursors)

    -- Rotate the main cursor.
    set({ "n", "v" }, "<a-l>", mc.nextCursor)
    set({ "n", "v" }, "<a-h>", mc.prevCursor)

    -- Delete the main cursor.
    set({ "n", "v" }, "<a-d>", mc.deleteCursor)

    -- Add and remove cursors with control + left click.
    set("n", "<a-leftmouse>", mc.handleMouse)

    -- ESC support for clearing cursors.
    set("n", "<esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        -- Default <esc> handler.
      end
    end)

    -- bring back cursors if you accidentally clear them
    set("n", "<a-r>", mc.restoreCursors)

    -- Jumplist support
    set({ "v", "n" }, "<c-i>", mc.jumpForward)
    set({ "v", "n" }, "<c-o>", mc.jumpBackward)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { link = "Cursor" })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
