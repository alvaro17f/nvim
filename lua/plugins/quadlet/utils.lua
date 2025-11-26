return {
  ensure_quadlet_lsp_binary = function()
    local target_dir

    if Flags.mason then
      target_dir = vim.fn.stdpath("data") .. "/mason/bin"
    else
      target_dir = vim.fn.expand("~/bin")
    end

    local binary_path = target_dir .. "/quadlet-lsp"

    if vim.fn.executable("quadlet-lsp") == 1 then
      return
    end

    if vim.fn.filereadable(binary_path) == 1 then
      vim.fn.setfperm(binary_path, "755")
      return
    end

    vim.fn.mkdir(target_dir, "p")

    local script = [[
    #!/usr/bin/env bash
    set -e

    TARGET_DIR="]] .. target_dir .. [["
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"

    curl -sL "https://api.github.com/repos/onlyati/quadlet-lsp/releases/latest" > release.json

    TARBALL_URL=$(grep -o '"browser_download_url": ".*linux.*tar\.gz"' release.json | cut -d'"' -f4 | head -1)

    if [ -n "$TARBALL_URL" ]; then
      curl -L "$TARBALL_URL" -o quadlet-lsp.tar.gz &> /dev/null

      tar -xzf quadlet-lsp.tar.gz &> /dev/null

      find . -name "quadlet-lsp" -type f -exec cp {} "$TARGET_DIR/quadlet-lsp" \; 
      chmod +x "$TARGET_DIR/quadlet-lsp" &> /dev/null
    else
      exit 1
    fi

    cd /
    rm -rf "$TEMP_DIR"
  ]]

    local success = os.execute(script)
    if success ~= 0 then
      vim.notify("Failed to download and setup quadlet-lsp binary", vim.log.levels.ERROR)
    end
  end,
}
