# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) — a single-file, non-distribution starting point. The upstream `init.lua` is intentionally one large file (~950 lines) containing all options, keymaps, autocommands, and plugin specs.

## Formatting

```bash
stylua --check .   # check formatting (matches CI)
stylua .           # auto-format all Lua files
```

Key `.stylua.toml` rules: 2-space indent, 160-column width, single quotes preferred, no parentheses on standalone calls (so `require 'module'` not `require('module')`), and simple statements collapsed to one line.

## Architecture

### Extension points (conflict-free)

**Never modify `init.lua` for personal settings** — it tracks upstream and will get merge conflicts. Instead:

- `lua/custom/plugins/*.lua` — loaded automatically via `{ import = 'custom.plugins' }` at the bottom of `init.lua`. Each file must return a valid lazy.nvim plugin spec (or `{}`). Side-effect code (like `vim.o` options) runs at import time, making this the right place for personal option overrides too.

### Plugin system

lazy.nvim is the plugin manager, bootstrapped automatically in `init.lua`. All core plugins are defined inline in `init.lua`. Optional upstream plugins live in `lua/kickstart/plugins/` and are enabled by uncommenting the corresponding `require 'kickstart.plugins.X'` lines near the bottom of `init.lua`.

### LSP

Uses the Neovim 0.11+ API (`vim.lsp.config()` / `vim.lsp.enable()`) rather than the older `lspconfig.server.setup{}` pattern. mason.nvim manages LSP server installation.

### Health check

`:checkhealth kickstart` — verifies Neovim >= 0.11, and that `git`, `make`, `unzip`, and `rg` are available on PATH.
