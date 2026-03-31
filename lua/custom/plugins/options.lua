vim.o.relativenumber = true

-- Nix wraps neovim with a restricted runtimepath; add the user data site dir
-- so that lazy.nvim-installed treesitter parsers are found.
vim.opt.runtimepath:append(vim.fn.stdpath 'data' .. '/site')

return {}
